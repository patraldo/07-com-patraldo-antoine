/**
 * @type {import('./$types').RequestHandler}
 */
export async function POST({ request }) {
  try {
    const { email } = await request.json();
    if (!email) {
      return new Response(
        JSON.stringify({ message: 'Email is required' }),
        { 
          status: 400, 
          headers: { 'Content-Type': 'application/json' } 
        }
      );
    }
    // Send to Cloudflare Worker
    const workerResponse = await fetch('https://subscribe.antoine.patraldo.com/subscribe', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email })
    });
    if (!workerResponse.ok) {
      const error = await workerResponse.text();
      throw new Error(`Worker error: ${error}`);
    }
    const result = await workerResponse.json();
    return new Response(
      JSON.stringify({ message: result.message }),
      { 
        status: 200, 
        headers: { 'Content-Type': 'application/json' } 
      }
    );
  } catch (error) {
    console.error('Subscription error:', error);
    return new Response(
      JSON.stringify({ message: 'Failed to subscribe. Please try again.' }),
      { 
        status: 500, 
        headers: { 'Content-Type': 'application/json' } 
      }
    );
  }
}
