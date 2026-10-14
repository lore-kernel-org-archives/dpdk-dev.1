Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EADCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:39:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 302F340272;
	Wed, 14 Oct 2026 14:39:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F2F84021E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791981559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcKMHaw++PWdJ7GWS0MerbOyU75GK73NyAq4Gt80lM0=;
 b=G4CF58rtwzqcPUf2ypgaKhoCRsno+PaF+pLXM4IuHqZQvJ2Eb6rjfdlfN6K7cZV7IpZChN
 lB4AiS+kB25BKSooja2PFsYwZ1gIyot83z5aq7TMFNwv5UKrGma7BXPlux0fbC8fPdUsWx
 uprQNwryZNoyelubVZxE2WOu2cvl/JI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-gJMwrXVXNzuZuL1WiU7TNw-1; Wed, 14 Oct 2026 12:39:17 +0000
X-MC-Unique: gJMwrXVXNzuZuL1WiU7TNw-1
X-Mimecast-MFC-AGG-ID: gJMwrXVXNzuZuL1WiU7TNw_1791981557
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1721559b4so42635125e9.1
 for <dev@dpdk.org>; Wed, 14 Oct 2026 05:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791981556; x=1792586356;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBC+pldReGNeV87LqwtexjzZHm2hOck6Nq63/xEcYwk=;
 b=lodEuQsN0A8hz27q+uPBCXnZX362WMNNtS7whAIc/FCot2MLDDuiyBNqzc3WEEabtn
 W66K/qwYGOiA83VP2oOmqwepbBrKE4Ap4jmMRTiTjxqBClzMWcngQWR9Ufeln4b4AB3U
 J6/M8q1yW25xP9lgZ0APeeOr4gBjEGtSYMxkUuPPb9bUdq6HADp2dCPitWBFgr77TfN+
 J/ILhzMbUcsknRmbEhvNFmRi1SRXHfDrHXz6SPBH09V/pjDIxX8SwjXrLhkhypEfgnkF
 JxfYwlgQVQsmXji2XrhasO8jjdQYOffeCz+vuvy4Y77pt+8i0DFWqA/j90kheNrviu/+
 YlyQ==
X-Gm-Message-State: AFq9FYItwzYtkK4N+xgkexYv7W69uD74/lNCURaFZW/ZjXMttNIC34c2
 ktzud7vnnMsclBRJne/nTjHCQMvXF5CMap4WOSz4FScFSfDTdq2O9ar6Dy7PIlB720IQTo/igiW
 vrol+yFqySm48OzPf9TRjxJwJYTt1KdNSjH8KikB5ODTM
X-Gm-Gg: AYBFou0iXSso7gYj2aVdpws5gv1AxJeWQozpTmon9bHL81gKjNyc/IxYcpd9noEDp2l
 PqcctZaYFnwjPatQ4gVhB6EZYkesjM78DMHHKQtvQNbRVHcLZDnx+tb7AMjzcpceIRqKUDUfWhc
 pNYIvfH0Dk9AWrLgwVt3T8/ee7Z/P80DEuVBQKiNgZLdSz77SwT539B1LVC+z8TCJewERtAVUZ8
 BTM2Y9qFEskWZc2bqim3H/1YFzI15eQwfDyD9NDR43fCB3fH4iT0paK9O5HTcSPBivSdYCYB3nK
 Yru2TGBl22uSD3ShMpNMzwFUB6IWOmjjLV+gF318LfHIJgzmsOm8H7a7FeyfoU7VkkbzWp/Shml
 FjEaK06nHNmFhbKLPIDTlWPbQvTcP8Q==
X-Received: by 2002:a05:600c:3488:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a18e4b8028mr321786225e9.17.1791981556058; 
 Wed, 14 Oct 2026 05:39:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3488:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a18e4b8028mr321785425e9.17.1791981555311; 
 Wed, 14 Oct 2026 05:39:15 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf214a1sm504738145e9.7.2026.10.14.05.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:39:12 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: dev@dpdk.org,  stephen@networkplumber.org
Subject: Re: [PATCH] devtools: add read-only tool calling support to AI
 review scripts
In-Reply-To: <CAKYPG+wwH8UG8D5n+agDNxg=xiVDOtrxS8pbF97GUhMeogXBpw@mail.gmail.com>
 (Koushik Bhargav Nimoji's message of "Thu, 8 Oct 2026 14:37:45 -0400")
References: <20260609182652.1053422-1-aconole@redhat.com>
 <20260909141356.1045836-1-aconole@redhat.com>
 <CAKYPG+wwH8UG8D5n+agDNxg=xiVDOtrxS8pbF97GUhMeogXBpw@mail.gmail.com>
Date: Wed, 14 Oct 2026 08:39:04 -0400
Message-ID: <f7tcxtcxxqv.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U1HPU2ixi7Z1p-04PsuLwJD1cs63M5xZVPhVet9wLFA_1791981557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Koushik Bhargav Nimoji <knimoji@iol.unh.edu> writes:

> Hi Aaron,
>
> Thank you for this patch. After looking at the code and testing the AI co=
de review, there's a few things I wanted to bring up.
> Firstly, I've noticed that the tool calling has been inconsistent. I ran =
the review on the AI tools patch without an Agents.md file, to which the AI
> ran a few tools and successfully gave me an output. However, when I ran i=
t a few times after, regardless of providing the Agents.md file I was
> seeing no tool calls run. Could this be because the AI decided it had eno=
ugh context to not need to invoke tools, or maybe even the AI does not
> know it has access to these tools/when to invoke them?
> I've also run it using Haiku 5.5, to which the AI tried a file_read tool =
call to read the patch, was unable to locate the file, but still went on to=
 review
> the patch as shown:

What is your path, etc?  The tool calling support really only wants to
run from the repo.  Notice that there is a failure saying it cannot find
a file you've specified:

  /home/knimoji/repos/dpdk-next-dts/RFC-dts-resolve-trex-driver-binding-iss=
ue.patch

There isn't a 'find' tool call, which means if you tell it to review
something and it cannot use the tools provided (grep, read, git, awk,
sed) to find that detail, it will error out.  Maybe after that it
hallucinates.  It's tough to predict how a specific model will proceed.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D Tool Use Round 1 =3D=3D=3D
>
> Calling tool: file_read
>
> Input: {
>
>   "path": "RFC-dts-resolve-trex-driver-binding-issue.patch"
>
> }
>
> Output: Tool error: File not found: /home/knimoji/repos/dpdk-next-dts/RFC=
-dts-resolve-trex-driver-binding-issue.patch
>
> Error occurred
>
> =3D=3D=3D Tool Use Complete (1 rounds) =3D=3D=3D
>
> =3D=3D=3D Token Usage =3D=3D=3D
>
> Input tokens: 29,377
>
> Output tokens: 2,428
>
> Cache creation: 22,984
>
> Cache read: 22,984
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D Patch Review: RFC-dts-resolve-trex-driver-binding-issue.patch (=
via Claude) =3D=3D=3D
>
> Review date: 2026-10-08
>
> I'll work with the patch content you've provided directly. Let me analyze=
 it systematically.
>
> ## DPDK Code Review: RFC-dts-resolve-trex-driver-binding-issue.patch
>
> ...
>
> On Wed, Sep 9, 2026 at 10:14=E2=80=AFAM Aaron Conole <aconole@redhat.com>=
 wrote:
>
>  Add an iterative tool-use loop to review-patch.py and review-doc.py
>  for Anthropic, OpenAI, and xAI providers. The AI reviewer can now
>  look up additional context from the DPDK source tree when the patch
>  or document alone is insufficient, rather than having to guess at
>  surrounding code, API contracts, commit history, or function
>  signatures.
>
>  Tool calling is enabled by default with a configurable limit
>  (default: 10 rounds). Pass '--no-tools' to disable it and restore
>  the previous single-shot behavior, or '--max-tool-rounds N' to
>  adjust the limit. The round limit prevents runaway execution on
>  complex reviews; when reached, the model delivers a final response
>  with the context gathered so far.
>
>  Tool set (_tools.py):
>    - git_log        View commit history with optional filters (author,
>                     date range, path, message grep)
>    - git_show       Display specific commits or file contents at a
>                     given ref, with optional diffstat
>    - grep           Search for regex patterns across files with
>                     configurable recursion, case sensitivity, match
>                     limits, and context lines
>    - awk            Process text with AWK programs (read-only, blocks
>                     system(), file writes, and command execution)
>    - sed            Process text with sed programs (read-only, -n mode
>                     enforced, blocks write/execute/read commands)
>    - file_read      Read file contents up to a configurable size limit
>                     (default 1MB) with encoding support
>
>  All tools validate paths using Path().is_relative_to() to prevent
>  directory traversal attacks. Tools are confined to the git repository
>  root and include 30-second timeouts to prevent hanging.
>
>  The _common.py send_request() function now handles the tool-calling
>  loop for supported providers, inspecting stop_reason (Anthropic) or
>  finish_reason (OpenAI/xAI) to determine if tool execution is needed,
>  then converting tool definitions between provider formats as required.
>
>  Assisted-by: Claude:sonnet-4.5
>  Signed-off-by: Aaron Conole <aconole@redhat.com>
>  ---
>  RFC -> PATCH:
>    - More (read-only) tools
>    - Resolve (most?) security escapes
>    - xAI support (since it is openAI compatible)
>
>   devtools/ai/_common.py      | 273 +++++++++++++--
>   devtools/ai/_tools.py       | 674 ++++++++++++++++++++++++++++++++++++
>   devtools/ai/review-doc.py   |  18 +
>   devtools/ai/review-patch.py |  22 ++
>   4 files changed, 966 insertions(+), 21 deletions(-)
>   create mode 100644 devtools/ai/_tools.py
>
>  diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py
>  index 07a0411aaf..bdbc91034f 100644
>  --- a/devtools/ai/_common.py
>  +++ b/devtools/ai/_common.py
>  @@ -369,39 +369,35 @@ def _print_verbose_usage(usage: TokenUsage) -> Non=
e:
>       print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", =
file=3Dsys.stderr)
>
>  -def send_request(
>  +def _execute_api_call(
>       provider: str,
>       auth: str,
>       model: str,
>       request_data: dict[str, Any],
>  -    *,
>  -    timeout: int =3D 120,
>  -    verbose: bool =3D False,
>  -) -> tuple[str, TokenUsage]:
>  -    """Send a prebuilt request to a provider and return (response_text,=
 usage).
>  -
>  -    The caller assembles the provider-specific request body via its own
>  -    build_*_request helpers (the prompts differ per script). This funct=
ion
>  -    handles transport, error reporting, and token-usage extraction.
>  +    timeout: int,
>  +) -> dict[str, Any]:
>  +    """Execute a single API call and return the result.
>
>       Args:
>  -        provider: Provider name (anthropic, openai, xai, google)
>  -        auth: Authentication string - either "direct:<api_key>" or "ver=
tex"
>  +        provider: Provider name
>  +        auth: Authentication string
>           model: Model identifier
>  -        request_data: Provider-specific request payload
>  +        request_data: Request payload
>           timeout: Request timeout in seconds
>  -        verbose: Show detailed token usage
>
>       Returns:
>  -        Tuple of (response_text, token_usage)
>  +        API response as dictionary
>  +
>  +    Raises:
>  +        Calls error() on failure (does not return)
>       """
>  -    url, headers, request_data =3D _build_request_meta(provider, auth, =
model, request_data)
>  -    body =3D json.dumps(request_data).encode("utf-8")
>  +    url, headers, req_data =3D _build_request_meta(provider, auth, mode=
l, request_data)
>  +    body =3D json.dumps(req_data).encode("utf-8")
>       req =3D Request(url, data=3Dbody, headers=3Dheaders)
>
>       try:
>           with urlopen(req, timeout=3Dtimeout) as response:
>  -            result =3D json.loads(response.read().decode("utf-8"))
>  +            return json.loads(response.read().decode("utf-8"))
>       except HTTPError as e:
>           error_body =3D e.read().decode("utf-8")
>           try:
>  @@ -421,7 +417,242 @@ def send_request(
>       except TimeoutError:
>           error(f"Request timed out after {timeout} seconds")
>
>  -    usage =3D _extract_usage(provider, result)
>  +
>  +def _handle_anthropic_tool_use(
>  +    result: dict[str, Any],
>  +    messages: list[dict[str, Any]],
>  +    verbose: bool,
>  +    round_num: int,
>  +) -> bool:
>  +    """Handle Anthropic tool use response.
>  +
>  +    Args:
>  +        result: API response
>  +        messages: Message history (modified in place)
>  +        verbose: Print debug info
>  +        round_num: Current round number (for logging)
>  +
>  +    Returns:
>  +        True if tools were used, False otherwise
>  +    """
>  +    stop_reason =3D result.get("stop_reason")
>  +    if stop_reason !=3D "tool_use":
>  +        return False
>  +
>  +    try:
>  +        from _tools import execute_tool
>  +    except ImportError:
>  +        def execute_tool(tool_name, tool_input):
>  +            raise RuntimeError(f"Cannot run {tool_name} - bad _tools.py=
")
>  +
>  +    content_blocks =3D result.get("content", [])
>  +    tool_results =3D []
>  +
>  +    if verbose:
>  +        print(f"\n=3D=3D=3D Tool Use Round {round_num + 1} =3D=3D=3D", =
file=3Dsys.stderr)
>  +
>  +    for block in content_blocks:
>  +        if block.get("type") =3D=3D "tool_use":
>  +            tool_name =3D block.get("name")
>  +            tool_input =3D block.get("input", {})
>  +            tool_use_id =3D block.get("id")
>  +
>  +            if verbose:
>  +                print(f"Calling tool: {tool_name}", file=3Dsys.stderr)
>  +                print(f"Input: {json.dumps(tool_input, indent=3D2)}", f=
ile=3Dsys.stderr)
>  +
>  +            # Execute the tool
>  +            try:
>  +                tool_output =3D execute_tool(tool_name, tool_input)
>  +                is_error =3D False
>  +            except Exception as e:
>  +                tool_output =3D f"Tool error: {e}"
>  +                is_error =3D True
>  +
>  +            if verbose:
>  +                output_preview =3D tool_output[:200] + "..." if len(too=
l_output) > 200 else tool_output
>  +                print(f"Output: {output_preview}", file=3Dsys.stderr)
>  +                if is_error:
>  +                    print(f"Error occurred", file=3Dsys.stderr)
>  +
>  +            tool_results.append({
>  +                "type": "tool_result",
>  +                "tool_use_id": tool_use_id,
>  +                "content": tool_output,
>  +                "is_error": is_error,
>  +            })
>  +
>  +    # Add assistant message with tool use
>  +    messages.append({
>  +        "role": "assistant",
>  +        "content": content_blocks,
>  +    })
>  +
>  +    # Add user message with tool results
>  +    messages.append({
>  +        "role": "user",
>  +        "content": tool_results,
>  +    })
>  +
>  +    return True
>  +
>  +
>  +def _handle_openai_tool_use(
>  +    result: dict[str, Any],
>  +    messages: list[dict[str, Any]],
>  +    verbose: bool,
>  +    round_num: int,
>  +) -> bool:
>  +    """Handle OpenAI/xAI tool use response.
>  +
>  +    Args:
>  +        result: API response
>  +        messages: Message history (modified in place)
>  +        verbose: Print debug info
>  +        round_num: Current round number (for logging)
>  +
>  +    Returns:
>  +        True if tools were used, False otherwise
>  +    """
>  +    choices =3D result.get("choices", [])
>  +    if not choices:
>  +        return False
>  +
>  +    message =3D choices[0].get("message", {})
>  +    tool_calls =3D message.get("tool_calls")
>  +
>  +    if not tool_calls:
>  +        return False
>  +
>       if verbose:
>  -        _print_verbose_usage(usage)
>  -    return _extract_text(provider, result), usage
>  +        print(f"\n=3D=3D=3D Tool Use Round {round_num + 1} =3D=3D=3D", =
file=3Dsys.stderr)
>  +
>  +    # Add assistant message with tool calls
>  +    messages.append(message)
>  +
>  +    # Execute each tool and collect results
>  +    tool_messages =3D []
>  +    for tool_call in tool_calls:
>  +        tool_id =3D tool_call.get("id")
>  +        function =3D tool_call.get("function", {})
>  +        tool_name =3D function.get("name")
>  +        tool_args_str =3D function.get("arguments", "{}")
>  +
>  +        try:
>  +            tool_input =3D json.loads(tool_args_str)
>  +        except json.JSONDecodeError:
>  +            tool_input =3D {}
>  +
>  +        if verbose:
>  +            print(f"Calling tool: {tool_name}", file=3Dsys.stderr)
>  +            print(f"Input: {json.dumps(tool_input, indent=3D2)}", file=
=3Dsys.stderr)
>  +
>  +        # Execute the tool
>  +        try:
>  +            from _tools import execute_tool
>  +            tool_output =3D execute_tool(tool_name, tool_input)
>  +        except Exception as e:
>  +            tool_output =3D f"Tool error: {e}"
>  +
>  +        if verbose:
>  +            output_preview =3D tool_output[:200] + "..." if len(tool_ou=
tput) > 200 else tool_output
>  +            print(f"Output: {output_preview}", file=3Dsys.stderr)
>  +
>  +        tool_messages.append({
>  +            "role": "tool",
>  +            "tool_call_id": tool_id,
>  +            "name": tool_name,
>  +            "content": tool_output,
>  +        })
>  +
>  +    # Add all tool results as separate messages
>  +    messages.extend(tool_messages)
>  +    return True
>  +
>  +
>  +def send_request(
>  +    provider: str,
>  +    auth: str,
>  +    model: str,
>  +    request_data: dict[str, Any],
>  +    *,
>  +    timeout: int =3D 120,
>  +    verbose: bool =3D False,
>  +    enable_tools: bool =3D False,
>  +    max_tool_rounds: int =3D 10,
>  +) -> tuple[str, TokenUsage]:
>  +    """Send a prebuilt request to a provider and return (response_text,=
 usage).
>  +
>  +    The caller assembles the provider-specific request body via its own
>  +    build_*_request helpers (the prompts differ per script). This funct=
ion
>  +    handles transport, error reporting, and token-usage extraction.
>  +
>  +    If enable_tools is True, implements a tool-use loop where the model=
 can
>  +    call tools, this function executes them, and sends results back unt=
il
>  +    the model returns a text response.
>  +
>  +    Args:
>  +        provider: Provider name (anthropic, openai, xai, google)
>  +        auth: Authentication string - either "direct:<api_key>" or "ver=
tex"
>  +        model: Model identifier
>  +        request_data: Provider-specific request payload
>  +        timeout: Request timeout in seconds
>  +        verbose: Show detailed token usage
>  +        enable_tools: Enable tool calling support
>  +        max_tool_rounds: Maximum number of tool calling rounds (default=
: 10)
>  +
>  +    Returns:
>  +        Tuple of (response_text, token_usage)
>  +    """
>  +    # Add tools to request if enabled
>  +    if enable_tools:
>  +        if provider =3D=3D "anthropic":
>  +            from _tools import get_tools_for_provider
>  +            request_data["tools"] =3D get_tools_for_provider(provider)
>  +        elif provider in ("openai", "xai"):
>  +            from _tools import get_tools_for_provider
>  +            request_data["tools"] =3D get_tools_for_provider(provider)
>  +            # Disable parallel tool calling for OpenAI/xAI (sequential =
execution only)
>  +            request_data["parallel_tool_calls"] =3D False
>  +        elif provider =3D=3D "google":
>  +            # Google Gemini tool calling not yet implemented
>  +            if verbose:
>  +                print("Warning: Tool calling not yet supported for Goog=
le Gemini", file=3Dsys.stderr)
>  +            enable_tools =3D False
>  +
>  +    total_usage =3D TokenUsage()
>  +    messages =3D request_data.get("messages", [])
>  +
>  +    # Tool use loop
>  +    for round_num in range(max_tool_rounds):
>  +        result =3D _execute_api_call(provider, auth, model, request_dat=
a, timeout)
>  +
>  +        usage =3D _extract_usage(provider, result)
>  +        total_usage.add(usage)
>  +
>  +        # Check if tools were used
>  +        tools_used =3D False
>  +        if enable_tools:
>  +            if provider =3D=3D "anthropic":
>  +                tools_used =3D _handle_anthropic_tool_use(result, messa=
ges, verbose, round_num)
>  +            elif provider in ("openai", "xai"):
>  +                tools_used =3D _handle_openai_tool_use(result, messages=
, verbose, round_num)
>  +
>  +        if not tools_used:
>  +            # Final response
>  +            if verbose and round_num > 0:
>  +                print(f"=3D=3D=3D Tool Use Complete ({round_num} rounds=
) =3D=3D=3D\n", file=3Dsys.stderr)
>  +            if verbose:
>  +                _print_verbose_usage(total_usage)
>  +            return _extract_text(provider, result), total_usage
>  +
>  +        # Update messages for next round
>  +        request_data["messages"] =3D messages
>  +
>  +    # Max rounds exceeded
>  +    if verbose:
>  +        print(f"Warning: Max tool rounds ({max_tool_rounds}) exceeded",=
 file=3Dsys.stderr)
>  +        _print_verbose_usage(total_usage)
>  +
>  +    # Return whatever we have
>  +    return _extract_text(provider, result), total_usage
>  diff --git a/devtools/ai/_tools.py b/devtools/ai/_tools.py
>  new file mode 100644
>  index 0000000000..a74d354982
>  --- /dev/null
>  +++ b/devtools/ai/_tools.py
>  @@ -0,0 +1,674 @@
>  +#!/usr/bin/env python3
>  +# SPDX-License-Identifier: BSD-3-Clause
>  +# Copyright(c) 2026 Aaron Conole
>  +
>  +"""
>  +Read-only tool calling support for DPDK AI review scripts.
>  +
>  +Provides secure, sandboxed tools for AI to gather additional context:
>  +- git log: View commit history
>  +- git show: View specific commits
>  +- grep: Search file contents
>  +- awk/sed: Parse and extract text (read-only)
>  +- file_read: Read file contents
>  +
>  +All tools validate paths to prevent escaping the git repository.
>  +"""
>  +
>  +import json
>  +import re
>  +import subprocess
>  +from pathlib import Path
>  +from typing import Any, NoReturn
>  +
>  +
>  +class ToolError(Exception):
>  +    """Raised when a tool execution fails."""
>  +    pass
>  +
>  +
>  +class SecurityError(Exception):
>  +    """Raised when a security constraint is violated."""
>  +    pass
>  +
>  +
>  +def get_git_root() -> Path:
>  +    """Get the root directory of the git repository.
>  +
>  +    Returns:
>  +        Path to the git repository root
>  +
>  +    Raises:
>  +        ToolError: If not in a git repository
>  +    """
>  +    try:
>  +        result =3D subprocess.run(
>  +            ["git", "rev-parse", "--show-toplevel"],
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            check=3DTrue,
>  +        )
>  +        return Path(result.stdout.strip()).resolve()
>  +    except (subprocess.CalledProcessError, FileNotFoundError) as e:
>  +        raise ToolError(f"Not in a git repository: {e}") from e
>  +
>  +
>  +def validate_path(path_str: str, git_root: Path) -> Path:
>  +    """Validate that a path is within the git repository.
>  +
>  +    Uses Path.is_relative_to() to prevent directory traversal attacks.
>  +
>  +    Args:
>  +        path_str: Path string to validate
>  +        git_root: Root of the git repository
>  +
>  +    Returns:
>  +        Resolved absolute Path object
>  +
>  +    Raises:
>  +        SecurityError: If path escapes the git repository
>  +    """
>  +    try:
>  +        # Convert to absolute path and resolve symlinks
>  +        if Path(path_str).is_absolute():
>  +            resolved =3D Path(path_str).resolve()
>  +        else:
>  +            resolved =3D (git_root / path_str).resolve()
>  +
>  +        # Check if path is within git root
>  +        if not resolved.is_relative_to(git_root):
>  +            raise SecurityError(
>  +                f"Path '{path_str}' escapes git repository root '{git_r=
oot}'"
>  +            )
>  +
>  +        return resolved
>  +
>  +    except (ValueError, OSError, RuntimeError) as e:
>  +        raise SecurityError(f"Invalid path '{path_str}': {e}") from e
>  +
>  +
>  +def validate_git_ref(ref: str) -> None:
>  +    """Validate a git reference (commit hash, branch, tag).
>  +
>  +    Args:
>  +        ref: Git reference to validate
>  +
>  +    Raises:
>  +        SecurityError: If reference contains suspicious characters
>  +    """
>  +    # Allow alphanumeric, -, _, /, ^, ~, @ (normal git ref characters)
>  +    # Disallow command injection characters: ; | & $ ( ) ` < > etc.
>  +    if not re.match(r'^[a-zA-Z0-9._/^~@-]+$', ref):
>  +        raise SecurityError(f"Invalid git reference: {ref}")
>  +
>  +
>  +def tool_git_log(args: dict[str, Any], git_root: Path) -> str:
>  +    """Execute git log with controlled arguments.
>  +
>  +    Args:
>  +        args: Dictionary with optional keys:
>  +            - max_count: Maximum number of commits (default: 20, max: 1=
00)
>  +            - since: Date/time since (e.g., "2 weeks ago")
>  +            - until: Date/time until
>  +            - path: File path to filter by
>  +            - grep: Commit message grep pattern
>  +            - author: Author name/email filter
>  +            - oneline: Use oneline format (default: False)
>  +
>  +    Returns:
>  +        Git log output as string
>  +
>  +    Raises:
>  +        ToolError: If git command fails
>  +        SecurityError: If validation fails
>  +    """
>  +    cmd =3D ["git", "log"]
>  +
>  +    # Validate and add max_count
>  +    max_count =3D args.get("max_count", 20)
>  +    if not isinstance(max_count, int) or max_count < 1 or max_count > 1=
00:
>  +        raise ToolError("max_count must be an integer between 1 and 100=
")
>  +    cmd.extend([f"-{max_count}"])
>  +
>  +    # Add optional filters
>  +    if args.get("oneline"):
>  +        cmd.append("--oneline")
>  +    else:
>  +        cmd.append("--format=3D%H%n%an <%ae>%n%ad%n%s%n%b%n---")
>  +
>  +    if "since" in args:
>  +        cmd.extend(["--since", args["since"]])
>  +
>  +    if "until" in args:
>  +        cmd.extend(["--until", args["until"]])
>  +
>  +    if "author" in args:
>  +        cmd.extend(["--author", args["author"]])
>  +
>  +    if "grep" in args:
>  +        cmd.extend(["--grep", args["grep"]])
>  +
>  +    # Validate and add path filter
>  +    if "path" in args:
>  +        path =3D validate_path(args["path"], git_root)
>  +        cmd.extend(["--", str(path)])
>  +
>  +    try:
>  +        result =3D subprocess.run(
>  +            cmd,
>  +            cwd=3Dgit_root,
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            check=3DTrue,
>  +            timeout=3D30,
>  +        )
>  +        return result.stdout
>  +    except subprocess.TimeoutExpired:
>  +        raise ToolError("git log timed out after 30 seconds")
>  +    except subprocess.CalledProcessError as e:
>  +        raise ToolError(f"git log failed: {e.stderr}")
>  +
>  +
>  +def tool_git_show(args: dict[str, Any], git_root: Path) -> str:
>  +    """Show a git commit or object.
>  +
>  +    Args:
>  +        args: Dictionary with keys:
>  +            - ref: Git reference (commit hash, branch, tag)
>  +            - path: Optional path to show specific file at that ref
>  +            - stat: Show diffstat only (default: False)
>  +
>  +    Returns:
>  +        Git show output as string
>  +
>  +    Raises:
>  +        ToolError: If git command fails
>  +        SecurityError: If validation fails
>  +    """
>  +    if "ref" not in args:
>  +        raise ToolError("ref parameter is required")
>  +
>  +    ref =3D args["ref"]
>  +    validate_git_ref(ref)
>  +
>  +    cmd =3D ["git", "show"]
>  +
>  +    if args.get("stat"):
>  +        cmd.append("--stat")
>  +
>  +    # Construct the ref:path or just ref
>  +    if "path" in args:
>  +        path =3D validate_path(args["path"], git_root)
>  +        # Use relative path for git show
>  +        rel_path =3D path.relative_to(git_root)
>  +        cmd.append(f"{ref}:{rel_path}")
>  +    else:
>  +        cmd.append(ref)
>  +
>  +    try:
>  +        result =3D subprocess.run(
>  +            cmd,
>  +            cwd=3Dgit_root,
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            check=3DTrue,
>  +            timeout=3D30,
>  +        )
>  +        return result.stdout
>  +    except subprocess.TimeoutExpired:
>  +        raise ToolError("git show timed out after 30 seconds")
>  +    except subprocess.CalledProcessError as e:
>  +        raise ToolError(f"git show failed: {e.stderr}")
>  +
>  +
>  +def tool_grep(args: dict[str, Any], git_root: Path) -> str:
>  +    """Search for pattern in files using grep.
>  +
>  +    Args:
>  +        args: Dictionary with keys:
>  +            - pattern: Search pattern (required)
>  +            - path: File or directory path (default: current directory)
>  +            - recursive: Recursive search (default: True)
>  +            - ignore_case: Case-insensitive search (default: False)
>  +            - max_count: Maximum matches per file (default: 100)
>  +            - context: Lines of context (default: 0)
>  +
>  +    Returns:
>  +        Grep output as string
>  +
>  +    Raises:
>  +        ToolError: If grep fails
>  +        SecurityError: If validation fails
>  +    """
>  +    if "pattern" not in args:
>  +        raise ToolError("pattern parameter is required")
>  +
>  +    pattern =3D args["pattern"]
>  +    path =3D validate_path(args.get("path", "."), git_root)
>  +
>  +    cmd =3D ["grep", "--color=3Dnever"]
>  +
>  +    if args.get("ignore_case", False):
>  +        cmd.append("-i")
>  +
>  +    if args.get("recursive", True) and path.is_dir():
>  +        cmd.append("-r")
>  +
>  +    max_count =3D args.get("max_count", 100)
>  +    if not isinstance(max_count, int) or max_count < 0:
>  +       raise ToolError("max_count must be a non-negative integer")
>  +    if max_count > 0:
>  +        cmd.extend(["-m", str(max_count)])
>  +
>  +    context =3D args.get("context", 0)
>  +    if not isinstance(context, int) or context < 0 or context > 100:
>  +        raise ToolError(
>  +            "context must be a non-negative integer not greater than 10=
0")
>  +    cmd.extend(["-C", str(context)])
>  +
>  +    # Use -- to prevent pattern from being interpreted as an option
>  +    cmd.extend(["--", pattern, str(path)])
>  +
>  +    try:
>  +        result =3D subprocess.run(
>  +            cmd,
>  +            cwd=3Dgit_root,
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            timeout=3D30,
>  +        )
>  +        # grep returns 1 if no matches, which is not an error
>  +        if result.returncode not in (0, 1):
>  +            raise ToolError(f"grep failed: {result.stderr}")
>  +        return result.stdout
>  +    except subprocess.TimeoutExpired:
>  +        raise ToolError("grep timed out after 30 seconds")
>  +
>  +
>  +def tool_awk(args: dict[str, Any], git_root: Path) -> str:
>  +    """Execute awk for text processing (read-only).
>  +
>  +    Args:
>  +        args: Dictionary with keys:
>  +            - program: AWK program (required)
>  +            - path: File path (required)
>  +
>  +    Returns:
>  +        AWK output as string
>  +
>  +    Raises:
>  +        ToolError: If awk fails
>  +        SecurityError: If validation fails or program attempts writes
>  +    """
>  +    if "program" not in args or "path" not in args:
>  +        raise ToolError("program and path parameters are required")
>  +
>  +    program =3D args["program"]
>  +    path =3D validate_path(args["path"], git_root)
>  +
>  +    # Security: Disallow dangerous awk features
>  +    # Block system(), print/printf redirects, pipes, and getline
>  +    dangerous_patterns =3D [
>  +        r'system\s*\(',
>  +        r'(print|printf)\s*(.*\s*)>\s*',  # any print/printf redirect (=
with/without quotes)
>  +        r'(?<![|&])\|(?![|&])\s*', # pipe not preceded/followed by anot=
her | or &
>  +        r'getline',  # all getline operations
>  +    ]=20
>
> =20
> I looked into the regex parsing in the tool_awk function, to which I noti=
ced that the dangerous patterns could be bypassed if the AI passes
> forbidden features part by part, for example if "sys" and "tem" are passe=
d individually, it passes the regex check, but when the command runs
> it concatenates the 2 strings resulting in "system" which is forbidden. F=
or example:
>
> part1 =3D "sys"
>
> part2 =3D "tem"
>
> cmd =3D part1 part2
>
> @cmd("rm -rf /")
>
> If you think this would be an issue, I would recommend looking into awk's=
 built in '--sandbox' argument, which inherently disables commands
> such as system(), getline, pipes, and file redirects.
>
> =20
>  +    for pattern in dangerous_patterns:
>  +        if re.search(pattern, program):
>  +            raise SecurityError(f"AWK program contains forbidden patter=
n: {pattern}")
>  +
>  +    if not path.exists():
>  +        raise ToolError(f"File not found: {path}")
>  +
>  +    cmd =3D ["awk", program, str(path)]
>  +
>  +    try:
>  +        result =3D subprocess.run(
>  +            cmd,
>  +            cwd=3Dgit_root,
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            check=3DTrue,
>  +            timeout=3D30,
>  +        )
>  +        return result.stdout
>  +    except subprocess.TimeoutExpired:
>  +        raise ToolError("awk timed out after 30 seconds")
>  +    except subprocess.CalledProcessError as e:
>  +        raise ToolError(f"awk failed: {e.stderr}")
>  +
>  +
>  +def tool_sed(args: dict[str, Any], git_root: Path) -> str:
>  +    """Execute sed for text processing (read-only).
>  +
>  +    Args:
>  +        args: Dictionary with keys:
>  +            - program: sed program (required)
>  +            - path: File path (required)
>  +
>  +    Returns:
>  +        sed output as string
>  +
>  +    Raises:
>  +        ToolError: If sed fails
>  +        SecurityError: If validation fails or program attempts writes
>  +    """
>  +    if "program" not in args or "path" not in args:
>  +        raise ToolError("program and path parameters are required")
>  +
>  +    program =3D args["program"]
>  +    path =3D validate_path(args["path"], git_root)
>  +
>  +    # Security: Force read-only mode, disallow write/execute commands
>  +    # Block w (write), W (Write), e (execute), r/R (read from file), Q =
(quit with code)
>  +    dangerous_patterns =3D [
>  +        r'[wWeRQ]\s',  # write, Write, execute, Read, Quit
>  +        r'\d+[wWeRQ]$',  # write/execute/read/quit with address
>  +        r'[rR][/\s]',  # read from file (with or without whitespace)
>  +    ]
>
> =20
> When checking for dangerous commands using regex here, I was wondering if=
 this would affect regular commands that match the patterns?
> Please correct me if I'm wrong, but I wanted to make sure that the specif=
ied regex patterns wouldn't block commands that would be useful. =20
>
>  +    for pattern in dangerous_patterns:
>  +        if re.search(pattern, program):
>  +            raise SecurityError(f"sed program contains forbidden patter=
n: {pattern}")
>  +
>  +    if not path.exists():
>  +        raise ToolError(f"File not found: {path}")
>  +
>  +    # Always use -n (suppress automatic printing) to prevent side effec=
ts
>  +    cmd =3D ["sed", "-n", program, str(path)]
>  +
>  +    try:
>  +        result =3D subprocess.run(
>  +            cmd,
>  +            cwd=3Dgit_root,
>  +            capture_output=3DTrue,
>  +            text=3DTrue,
>  +            check=3DTrue,
>  +            timeout=3D30,
>  +        )
>  +        return result.stdout
>  +    except subprocess.TimeoutExpired:
>  +        raise ToolError("sed timed out after 30 seconds")
>  +    except subprocess.CalledProcessError as e:
>  +        raise ToolError(f"sed failed: {e.stderr}")
>  +
>  +
>  +def tool_file_read(args: dict[str, Any], git_root: Path) -> str:
>  +    """Read contents of a file.
>  +
>  +    Args:
>  +        args: Dictionary with keys:
>  +            - path: File path (required)
>  +            - max_size: Maximum file size in bytes (default: 1MB)
>  +            - encoding: Text encoding (default: utf-8)
>  +
>  +    Returns:
>  +        File contents as string
>  +
>  +    Raises:
>  +        ToolError: If file read fails
>  +        SecurityError: If validation fails
>  +    """
>  +    if "path" not in args:
>  +        raise ToolError("path parameter is required")
>  +
>  +    path =3D validate_path(args["path"], git_root)
>  +    max_size =3D args.get("max_size", 1024 * 1024)  # 1MB default
>  +    encoding =3D args.get("encoding", "utf-8")
>  +
>  +    if not path.exists():
>  +        raise ToolError(f"File not found: {path}")
>  +
>  +    if not path.is_file():
>  +        raise ToolError(f"Not a file: {path}")
>  +
>  +    # Check file size
>  +    file_size =3D path.stat().st_size
>  +    if file_size > max_size:
>  +        raise ToolError(
>  +            f"File too large: {file_size} bytes (max: {max_size})"
>  +        )
>  +
>  +    try:
>  +        # Use errors=3D'replace' to handle non-UTF8 bytes gracefully
>  +        return path.read_text(encoding=3Dencoding, errors=3D'replace')
>  +    except Exception as e:
>  +        raise ToolError(f"Failed to read file: {e}") from e
>  +
>  +
>  +# Tool definitions for Anthropic API
>  +TOOL_DEFINITIONS =3D [
>  +    {
>  +        "name": "git_log",
>  +        "description": "View git commit history with optional filters. =
Use this to understand recent changes, find related commits, or trace the
>  history of specific files.",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "max_count": {
>  +                    "type": "integer",
>  +                    "description": "Maximum number of commits to show (=
1-100, default: 20)",
>  +                    "minimum": 1,
>  +                    "maximum": 100,
>  +                },
>  +                "since": {
>  +                    "type": "string",
>  +                    "description": "Show commits more recent than date =
(e.g., '2 weeks ago', '2024-01-01')",
>  +                },
>  +                "until": {
>  +                    "type": "string",
>  +                    "description": "Show commits older than date",
>  +                },
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "Only show commits affecting this fi=
le path",
>  +                },
>  +                "grep": {
>  +                    "type": "string",
>  +                    "description": "Only show commits with messages mat=
ching this pattern",
>  +                },
>  +                "author": {
>  +                    "type": "string",
>  +                    "description": "Only show commits by this author",
>  +                },
>  +                "oneline": {
>  +                    "type": "boolean",
>  +                    "description": "Use compact one-line format (defaul=
t: false)",
>  +                },
>  +            },
>  +        },
>  +    },
>  +    {
>  +        "name": "git_show",
>  +        "description": "Show the contents of a git commit or a specific=
 file at a given commit. Use this to examine what changed in a specific
>  commit or to view historical file contents.",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "ref": {
>  +                    "type": "string",
>  +                    "description": "Git reference (commit hash, branch =
name, tag, or HEAD~N)",
>  +                },
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "Optional: specific file path to sho=
w at this ref",
>  +                },
>  +                "stat": {
>  +                    "type": "boolean",
>  +                    "description": "Show only diffstat (default: false)=
",
>  +                },
>  +            },
>  +            "required": ["ref"],
>  +        },
>  +    },
>  +    {
>  +        "name": "grep",
>  +        "description": "Search for text patterns in files. Use this to =
find specific code patterns, function definitions, or configuration values.=
",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "pattern": {
>  +                    "type": "string",
>  +                    "description": "Search pattern (supports regex)",
>  +                },
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "File or directory to search (defaul=
t: current directory)",
>  +                },
>  +                "recursive": {
>  +                    "type": "boolean",
>  +                    "description": "Search recursively in directories (=
default: true)",
>  +                },
>  +                "ignore_case": {
>  +                    "type": "boolean",
>  +                    "description": "Case-insensitive search (default: f=
alse)",
>  +                },
>  +                "max_count": {
>  +                    "type": "integer",
>  +                    "description": "Maximum matches per file (default: =
100)",
>  +                },
>  +                "context": {
>  +                    "type": "integer",
>  +                    "description": "Lines of context around matches (de=
fault: 0)",
>  +                },
>  +            },
>  +            "required": ["pattern"],
>  +        },
>  +    },
>  +    {
>  +        "name": "awk",
>  +        "description": "Process text files using AWK (read-only). Use t=
his to extract columns, filter lines, or perform text transformations.
>  Write/execute operations are blocked.",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "program": {
>  +                    "type": "string",
>  +                    "description": "AWK program to execute",
>  +                },
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "File to process",
>  +                },
>  +            },
>  +            "required": ["program", "path"],
>  +        },
>  +    },
>  +    {
>  +        "name": "sed",
>  +        "description": "Process text files using sed (read-only). Use t=
his to extract or transform text. Write/execute operations are blocked
>  and -n flag is always enabled.",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "program": {
>  +                    "type": "string",
>  +                    "description": "sed program to execute (use p comma=
nd to print)",
>  +                },
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "File to process",
>  +                },
>  +            },
>  +            "required": ["program", "path"],
>  +        },
>  +    },
>  +    {
>  +        "name": "file_read",
>  +        "description": "Read the contents of a file. Use this to examin=
e source code, documentation, or configuration files.",
>  +        "input_schema": {
>  +            "type": "object",
>  +            "properties": {
>  +                "path": {
>  +                    "type": "string",
>  +                    "description": "Path to the file to read",
>  +                },
>  +                "max_size": {
>  +                    "type": "integer",
>  +                    "description": "Maximum file size in bytes (default=
: 1048576 =3D 1MB)",
>  +                },
>  +                "encoding": {
>  +                    "type": "string",
>  +                    "description": "Text encoding (default: utf-8)",
>  +                },
>  +            },
>  +            "required": ["path"],
>  +        },
>  +    },
>  +]
>  +
>  +
>  +# Map tool names to handler functions
>  +TOOL_HANDLERS =3D {
>  +    "git_log": tool_git_log,
>  +    "git_show": tool_git_show,
>  +    "grep": tool_grep,
>  +    "awk": tool_awk,
>  +    "sed": tool_sed,
>  +    "file_read": tool_file_read,
>  +}
>  +
>  +
>  +def execute_tool(tool_name: str, tool_args: dict[str, Any]) -> str:
>  +    """Execute a tool and return its output.
>  +
>  +    Args:
>  +        tool_name: Name of the tool to execute
>  +        tool_args: Arguments for the tool
>  +
>  +    Returns:
>  +        Tool output as string
>  +
>  +    Raises:
>  +        ToolError: If tool execution fails
>  +        SecurityError: If security validation fails
>  +    """
>  +    if tool_name not in TOOL_HANDLERS:
>  +        raise ToolError(f"Unknown tool: {tool_name}")
>  +
>  +    git_root =3D get_git_root()
>  +    handler =3D TOOL_HANDLERS[tool_name]
>  +
>  +    try:
>  +        return handler(tool_args, git_root)
>  +    except (ToolError, SecurityError):
>  +        raise
>  +    except Exception as e:
>  +        raise ToolError(f"Tool execution failed: {e}") from e
>  +
>  +
>  +def convert_tools_to_openai_format(anthropic_tools: list[dict[str, Any]=
]) -> list[dict[str, Any]]:
>  +    """Convert Anthropic tool definitions to OpenAI function calling fo=
rmat.
>  +
>  +    Args:
>  +        anthropic_tools: List of tool definitions in Anthropic format
>  +
>  +    Returns:
>  +        List of tool definitions in OpenAI format
>  +    """
>  +    openai_tools =3D []
>  +    for tool in anthropic_tools:
>  +        openai_tool =3D {
>  +            "type": "function",
>  +            "function": {
>  +                "name": tool["name"],
>  +                "description": tool["description"],
>  +                "parameters": tool["input_schema"],
>  +            }
>  +        }
>  +        openai_tools.append(openai_tool)
>  +    return openai_tools
>  +
>  +
>  +def get_tools_for_provider(provider: str) -> list[dict[str, Any]]:
>  +    """Get tool definitions in the format required by the provider.
>  +
>  +    Args:
>  +        provider: Provider name (anthropic, openai, xai, google)
>  +
>  +    Returns:
>  +        List of tool definitions in provider-specific format
>  +    """
>  +    if provider =3D=3D "anthropic":
>  +        return TOOL_DEFINITIONS
>  +    elif provider in ("openai", "xai"):
>  +        return convert_tools_to_openai_format(TOOL_DEFINITIONS)
>  +    else:
>  +        # Google Gemini uses a different format, not yet implemented
>  +        return []
>  diff --git a/devtools/ai/review-doc.py b/devtools/ai/review-doc.py
>  index e01be077fe..a084678ec5 100755
>  --- a/devtools/ai/review-doc.py
>  +++ b/devtools/ai/review-doc.py
>  @@ -360,6 +360,8 @@ def call_api(
>       include_diff_markers: bool =3D False,
>       verbose: bool =3D False,
>       timeout: int =3D 120,
>  +    enable_tools: bool =3D True,
>  +    max_tool_rounds: int =3D 10,
>   ) -> tuple[str, TokenUsage]:
>       """Build the per-provider request body and dispatch via _common."""
>       if provider =3D=3D "anthropic":
>  @@ -399,6 +401,8 @@ def call_api(
>           request_data,
>           timeout=3Dtimeout,
>           verbose=3Dverbose,
>  +        enable_tools=3Denable_tools,
>  +        max_tool_rounds=3Dmax_tool_rounds,
>       )
>
>  @@ -665,6 +669,18 @@ def main() -> None:
>           metavar=3D"SECONDS",
>           help=3D"API request timeout in seconds (default: 120)",
>       )
>  +    parser.add_argument(
>  +        "--no-tools",
>  +        action=3D"store_true",
>  +        help=3D"Disable tool calling (git, grep, file read). Tools are =
enabled by default.",
>  +    )
>  +    parser.add_argument(
>  +        "--max-tool-rounds",
>  +        type=3Dint,
>  +        default=3D10,
>  +        metavar=3D"N",
>  +        help=3D"Maximum tool calling rounds (default: 10)",
>  +    )
>
>       # Email options
>       email_group =3D parser.add_argument_group("Email Options")
>  @@ -811,6 +827,8 @@ def main() -> None:
>               args.diff,
>               args.verbose,
>               args.timeout,
>  +            enable_tools=3Dnot args.no_tools,
>  +            max_tool_rounds=3Dargs.max_tool_rounds,
>           )
>           total_usage.add(call_usage)
>
>  diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
>  index 5f8d9ed772..a3481290be 100755
>  --- a/devtools/ai/review-patch.py
>  +++ b/devtools/ai/review-patch.py
>  @@ -589,6 +589,8 @@ def call_api(
>       output_format: str =3D "text",
>       verbose: bool =3D False,
>       timeout: int =3D 300,
>  +    enable_tools: bool =3D True,
>  +    max_tool_rounds: int =3D 10,
>   ) -> tuple[str, TokenUsage]:
>       """Build the per-provider request body and dispatch via _common."""
>       if provider =3D=3D "anthropic":
>  @@ -625,6 +627,8 @@ def call_api(
>           request_data,
>           timeout=3Dtimeout,
>           verbose=3Dverbose,
>  +        enable_tools=3Denable_tools,
>  +        max_tool_rounds=3Dmax_tool_rounds,
>       )
>
>  @@ -870,6 +874,18 @@ def main() -> None:
>           metavar=3D"SECONDS",
>           help=3D"API request timeout in seconds (default: 300)",
>       )
>  +    parser.add_argument(
>  +        "--no-tools",
>  +        action=3D"store_true",
>  +        help=3D"Disable tool calling (git, grep, file read). Tools are =
enabled by default.",
>  +    )
>  +    parser.add_argument(
>  +        "--max-tool-rounds",
>  +        type=3Dint,
>  +        default=3D10,
>  +        metavar=3D"N",
>  +        help=3D"Maximum tool calling rounds (default: 10)",
>  +    )
>
>       # Date and release options
>       parser.add_argument(
>  @@ -1079,6 +1095,8 @@ def main() -> None:
>                       args.output_format,
>                       args.verbose,
>                       args.timeout,
>  +                    enable_tools=3Dnot args.no_tools,
>  +                    max_tool_rounds=3Dargs.max_tool_rounds,
>                   )
>                   total_usage.add(call_usage)
>                   all_reviews.append((patch_label, review_text))
>  @@ -1149,6 +1167,8 @@ def main() -> None:
>                       args.output_format,
>                       args.verbose,
>                       args.timeout,
>  +                    enable_tools=3Dnot args.no_tools,
>  +                    max_tool_rounds=3Dargs.max_tool_rounds,
>                   )
>                   total_usage.add(call_usage)
>                   all_reviews.append((chunk_label, review_text))
>  @@ -1203,6 +1223,8 @@ def main() -> None:
>               args.output_format,
>               args.verbose,
>               args.timeout,
>  +            enable_tools=3Dnot args.no_tools,
>  +            max_tool_rounds=3Dargs.max_tool_rounds,
>           )
>           total_usage.add(call_usage)
>
>  --=20
>  2.55.0

