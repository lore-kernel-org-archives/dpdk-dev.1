Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5BCA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 18:38:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8150940294;
	Thu,  8 Oct 2026 20:38:24 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id BD2C640284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 20:38:22 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-533972e0cccso32729631cf.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 11:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791484702; cv=none;
 d=google.com; s=arc-20260327;
 b=OmugAHq1TfNrtdB8MAwdIHbXtYTYwXScb29Afq/ZUhPiI5xGVIPVa5ZXGK03swDPfM
 4p3X1Y10rT5yxVbFh4TMYSTVO4A/uOe1NfPAIxl5i1X7pUOBg5jZyy3sAOHSa+Jndpk2
 8p9JrcPpWAqoZHq4dwj7QGTWlwH595LKofSCG2Z4OgYec35Sm4acOmbeev+GVnaZ1Q4w
 eOuAJdS5qhstW+M4mpGQPwFrhx0yFLDXy5gb5a7UAc2C5D7V6Xqc5qhaarmcVIXl1f+g
 bsGTQnf5IcV4QkBvWCju6spFk0sdky+ZzUqGOn8yrUOKpVXXIP/eoF0OmD/sIsoK+Myj
 m/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+hvYZzDmR9prGnYMou1/vblZBWbnKhklu9ixotJJGxQ=;
 fh=7DSViN4FdP0GeilZ2Vue+3kMCsVVHXMhiIU+8V6+iuU=;
 b=b/f6jbDcIpfkADzObyXxDg90RrUdy2RbpC2Vddt1Xxg6wiGy86sBiNpLgQDwidnuIk
 oOrBjjAC5/d57FgV4j5VtPdg7XCfphNAtpiale3eDpEo3HAHBpvbJa931KU/q71xyXVI
 Rv1Z3ZiLBgkYSwQYuqZygrEkoz1fk7B9HR9C3/lzUGvZr7fLt66dzb7+RyBCB1b1inYp
 AFY/TfBmMK8EGNVEV/skK39DbRlNtUFrKVtbQuAPByLAcQhEQ3aKQu8Rt5vNR3gFkOlP
 tg8yQB/5cl5GPgfvkO/lu98VM82PxeC0PW/J6j8ig6QYi9zYKiCkl6tGo2JMpUS9bfmF
 URQw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1791484702; x=1792089502; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+hvYZzDmR9prGnYMou1/vblZBWbnKhklu9ixotJJGxQ=;
 b=dQeYF2pE4HOxV39M2hfFQidHeyFoLqvCJXwyPIA0w/FK8qabMGLHuQ5OQ3fiLW2gf7
 d25hWttO1qJhGewRZB+wiQByrgWplJBT/JOYck41BTHQfWRW74nOxRfMdIf8q3aevUiP
 4lD8yOtdl0fRy4vVogBskZPt56E4+vnTN04Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484702; x=1792089502;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+hvYZzDmR9prGnYMou1/vblZBWbnKhklu9ixotJJGxQ=;
 b=I62zUHOo0J/kU7+Qi2fTjjv6+YT9GXNgKy/3N0km5JIs5O3b0Tv5tOKPvlA1/4V2q1
 m42zV1kHWjvLui2O+qtFd3Pt0aIqBvXzfOLVSTP0Qv7upiy6xRKef+kANygRjSszhBJ/
 CvE3o7N9Zw3tNe5gf8WbmPboJvoViQm0At8ZCXzCmYmZJi8aKvCHCKZNLfV147C3ECbG
 HJa5kNxIVcYDt4TFOlUJjbNIwYd3bfczSy0/hoJm40nV5kNM2qG4Ty01lIO5tUjgw3mS
 IbDYoDf4CQSQfvvFl1/NXhUWrn+5J4mdSuf15BctezGGZG4aZ3e3FXlN/529EwmQf3I8
 9B3g==
X-Gm-Message-State: AFuF++mQpPTBKbrQC4zIOISfdSLb9cboPoWM+WMqhDFgFvYGUWTCmRQz
 Ar+ZShIacciGppOOwTuH6VtEMmm6udcyGqfZj6r5oEXMnzfM6PdTu0xYhFa61dc31i3HVTCi/GH
 HmC9+6jtDyiVS05XEMdkn5+vND6zrH+lS5rp/YBHkeQ==
X-Gm-Gg: AYBFou1RONv46Srh7ZHyIPMD4zFRA6LcuSf7HEZQJIig52x/f01qiI6SNt9A5CkNOy2
 RXBlQjuizfHSEb6IBkKuGskUhfKf5exjMb5KE/p6qRLAEwOb0P6Tzb2Y4HUC1MuBS4w5fnMonce
 an/6TCV25feuvkmw+AU2Zdga1YzTlxiTV30wleoUB0r+xMzdTlPWjAQAyDF3rMK6uhHnKD3V701
 CcDfI5nAMP8HwcJLC8zIObVgkyUq2vZEB9UkrD/PkvzuG/G7LaUtud2CLcW9fO+eTkGpfPG1iQW
 2IaJTrjxgrJTjnUL9JuLCHCqCuhiPsSDHGs9gbwATgGez/6E9KZzlehzioTYu96S+GcilGnGOEy
 H9S901k0T6WGTcAlYWZQcrqjmD8ZrRhhHvzx5PmGQ6l2ZEqXleAIRPpdEDaeX8kLuRa/Lv4h+aU
 lVXChnkhhstjf7RkfDxIfcdCemXYibJmkmHv99YolFIGWM
X-Received: by 2002:ac8:5a48:0:b0:535:70c4:9a8a with SMTP id
 d75a77b69052e-53575778ac4mr106371581cf.64.1791484701474; Thu, 08 Oct 2026
 11:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260609182652.1053422-1-aconole@redhat.com>
 <20260909141356.1045836-1-aconole@redhat.com>
In-Reply-To: <20260909141356.1045836-1-aconole@redhat.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 8 Oct 2026 14:37:45 -0400
X-Gm-Features: AclHuK8EUIoXXGKqsV2Isr7QOzUdzmfTvn0BZQDBkRiAfGJ_IVjK9EwZbPwmyA8
Message-ID: <CAKYPG+wwH8UG8D5n+agDNxg=xiVDOtrxS8pbF97GUhMeogXBpw@mail.gmail.com>
Subject: Re: [PATCH] devtools: add read-only tool calling support to AI review
 scripts
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="000000000000409621065d588970"
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

--000000000000409621065d588970
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

Thank you for this patch. After looking at the code and testing the AI code
review, there's a few things I wanted to bring up.
Firstly, I've noticed that the tool calling has been inconsistent. I ran
the review on the AI tools patch without an Agents.md file, to which the AI
ran a few tools and successfully gave me an output. However, when I ran it
a few times after, regardless of providing the Agents.md file I was seeing
no tool calls run. Could this be because the AI decided it had enough
context to not need to invoke tools, or maybe even the AI does not know it
has access to these tools/when to invoke them?
I've also run it using Haiku 5.5, to which the AI tried a file_read tool
call to read the patch, was unable to locate the file, but still went on to
review the patch as shown:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


=3D=3D=3D Tool Use Round 1 =3D=3D=3D

Calling tool: file_read

Input: {

  "path": "RFC-dts-resolve-trex-driver-binding-issue.patch"

}

Output: Tool error: File not found:
/home/knimoji/repos/dpdk-next-dts/RFC-dts-resolve-trex-driver-binding-issue=
.patch

Error occurred

=3D=3D=3D Tool Use Complete (1 rounds) =3D=3D=3D


=3D=3D=3D Token Usage =3D=3D=3D

Input tokens: 29,377

Output tokens: 2,428

Cache creation: 22,984

Cache read: 22,984

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D Patch Review: RFC-dts-resolve-trex-driver-binding-issue.patch (vi=
a
Claude) =3D=3D=3D

Review date: 2026-10-08


I'll work with the patch content you've provided directly. Let me analyze
it systematically.


## DPDK Code Review: RFC-dts-resolve-trex-driver-binding-issue.patch

...

On Wed, Sep 9, 2026 at 10:14=E2=80=AFAM Aaron Conole <aconole@redhat.com> w=
rote:

> Add an iterative tool-use loop to review-patch.py and review-doc.py
> for Anthropic, OpenAI, and xAI providers. The AI reviewer can now
> look up additional context from the DPDK source tree when the patch
> or document alone is insufficient, rather than having to guess at
> surrounding code, API contracts, commit history, or function
> signatures.
>
> Tool calling is enabled by default with a configurable limit
> (default: 10 rounds). Pass '--no-tools' to disable it and restore
> the previous single-shot behavior, or '--max-tool-rounds N' to
> adjust the limit. The round limit prevents runaway execution on
> complex reviews; when reached, the model delivers a final response
> with the context gathered so far.
>
> Tool set (_tools.py):
>   - git_log        View commit history with optional filters (author,
>                    date range, path, message grep)
>   - git_show       Display specific commits or file contents at a
>                    given ref, with optional diffstat
>   - grep           Search for regex patterns across files with
>                    configurable recursion, case sensitivity, match
>                    limits, and context lines
>   - awk            Process text with AWK programs (read-only, blocks
>                    system(), file writes, and command execution)
>   - sed            Process text with sed programs (read-only, -n mode
>                    enforced, blocks write/execute/read commands)
>   - file_read      Read file contents up to a configurable size limit
>                    (default 1MB) with encoding support
>
> All tools validate paths using Path().is_relative_to() to prevent
> directory traversal attacks. Tools are confined to the git repository
> root and include 30-second timeouts to prevent hanging.
>
> The _common.py send_request() function now handles the tool-calling
> loop for supported providers, inspecting stop_reason (Anthropic) or
> finish_reason (OpenAI/xAI) to determine if tool execution is needed,
> then converting tool definitions between provider formats as required.
>
> Assisted-by: Claude:sonnet-4.5
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> RFC -> PATCH:
>   - More (read-only) tools
>   - Resolve (most?) security escapes
>   - xAI support (since it is openAI compatible)
>
>  devtools/ai/_common.py      | 273 +++++++++++++--
>  devtools/ai/_tools.py       | 674 ++++++++++++++++++++++++++++++++++++
>  devtools/ai/review-doc.py   |  18 +
>  devtools/ai/review-patch.py |  22 ++
>  4 files changed, 966 insertions(+), 21 deletions(-)
>  create mode 100644 devtools/ai/_tools.py
>
> diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py
> index 07a0411aaf..bdbc91034f 100644
> --- a/devtools/ai/_common.py
> +++ b/devtools/ai/_common.py
> @@ -369,39 +369,35 @@ def _print_verbose_usage(usage: TokenUsage) -> None=
:
>      print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D", f=
ile=3Dsys.stderr)
>
>
> -def send_request(
> +def _execute_api_call(
>      provider: str,
>      auth: str,
>      model: str,
>      request_data: dict[str, Any],
> -    *,
> -    timeout: int =3D 120,
> -    verbose: bool =3D False,
> -) -> tuple[str, TokenUsage]:
> -    """Send a prebuilt request to a provider and return (response_text,
> usage).
> -
> -    The caller assembles the provider-specific request body via its own
> -    build_*_request helpers (the prompts differ per script). This functi=
on
> -    handles transport, error reporting, and token-usage extraction.
> +    timeout: int,
> +) -> dict[str, Any]:
> +    """Execute a single API call and return the result.
>
>      Args:
> -        provider: Provider name (anthropic, openai, xai, google)
> -        auth: Authentication string - either "direct:<api_key>" or
> "vertex"
> +        provider: Provider name
> +        auth: Authentication string
>          model: Model identifier
> -        request_data: Provider-specific request payload
> +        request_data: Request payload
>          timeout: Request timeout in seconds
> -        verbose: Show detailed token usage
>
>      Returns:
> -        Tuple of (response_text, token_usage)
> +        API response as dictionary
> +
> +    Raises:
> +        Calls error() on failure (does not return)
>      """
> -    url, headers, request_data =3D _build_request_meta(provider, auth,
> model, request_data)
> -    body =3D json.dumps(request_data).encode("utf-8")
> +    url, headers, req_data =3D _build_request_meta(provider, auth, model=
,
> request_data)
> +    body =3D json.dumps(req_data).encode("utf-8")
>      req =3D Request(url, data=3Dbody, headers=3Dheaders)
>
>      try:
>          with urlopen(req, timeout=3Dtimeout) as response:
> -            result =3D json.loads(response.read().decode("utf-8"))
> +            return json.loads(response.read().decode("utf-8"))
>      except HTTPError as e:
>          error_body =3D e.read().decode("utf-8")
>          try:
> @@ -421,7 +417,242 @@ def send_request(
>      except TimeoutError:
>          error(f"Request timed out after {timeout} seconds")
>
> -    usage =3D _extract_usage(provider, result)
> +
> +def _handle_anthropic_tool_use(
> +    result: dict[str, Any],
> +    messages: list[dict[str, Any]],
> +    verbose: bool,
> +    round_num: int,
> +) -> bool:
> +    """Handle Anthropic tool use response.
> +
> +    Args:
> +        result: API response
> +        messages: Message history (modified in place)
> +        verbose: Print debug info
> +        round_num: Current round number (for logging)
> +
> +    Returns:
> +        True if tools were used, False otherwise
> +    """
> +    stop_reason =3D result.get("stop_reason")
> +    if stop_reason !=3D "tool_use":
> +        return False
> +
> +    try:
> +        from _tools import execute_tool
> +    except ImportError:
> +        def execute_tool(tool_name, tool_input):
> +            raise RuntimeError(f"Cannot run {tool_name} - bad _tools.py"=
)
> +
> +    content_blocks =3D result.get("content", [])
> +    tool_results =3D []
> +
> +    if verbose:
> +        print(f"\n=3D=3D=3D Tool Use Round {round_num + 1} =3D=3D=3D",
> file=3Dsys.stderr)
> +
> +    for block in content_blocks:
> +        if block.get("type") =3D=3D "tool_use":
> +            tool_name =3D block.get("name")
> +            tool_input =3D block.get("input", {})
> +            tool_use_id =3D block.get("id")
> +
> +            if verbose:
> +                print(f"Calling tool: {tool_name}", file=3Dsys.stderr)
> +                print(f"Input: {json.dumps(tool_input, indent=3D2)}",
> file=3Dsys.stderr)
> +
> +            # Execute the tool
> +            try:
> +                tool_output =3D execute_tool(tool_name, tool_input)
> +                is_error =3D False
> +            except Exception as e:
> +                tool_output =3D f"Tool error: {e}"
> +                is_error =3D True
> +
> +            if verbose:
> +                output_preview =3D tool_output[:200] + "..." if
> len(tool_output) > 200 else tool_output
> +                print(f"Output: {output_preview}", file=3Dsys.stderr)
> +                if is_error:
> +                    print(f"Error occurred", file=3Dsys.stderr)
> +
> +            tool_results.append({
> +                "type": "tool_result",
> +                "tool_use_id": tool_use_id,
> +                "content": tool_output,
> +                "is_error": is_error,
> +            })
> +
> +    # Add assistant message with tool use
> +    messages.append({
> +        "role": "assistant",
> +        "content": content_blocks,
> +    })
> +
> +    # Add user message with tool results
> +    messages.append({
> +        "role": "user",
> +        "content": tool_results,
> +    })
> +
> +    return True
> +
> +
> +def _handle_openai_tool_use(
> +    result: dict[str, Any],
> +    messages: list[dict[str, Any]],
> +    verbose: bool,
> +    round_num: int,
> +) -> bool:
> +    """Handle OpenAI/xAI tool use response.
> +
> +    Args:
> +        result: API response
> +        messages: Message history (modified in place)
> +        verbose: Print debug info
> +        round_num: Current round number (for logging)
> +
> +    Returns:
> +        True if tools were used, False otherwise
> +    """
> +    choices =3D result.get("choices", [])
> +    if not choices:
> +        return False
> +
> +    message =3D choices[0].get("message", {})
> +    tool_calls =3D message.get("tool_calls")
> +
> +    if not tool_calls:
> +        return False
> +
>      if verbose:
> -        _print_verbose_usage(usage)
> -    return _extract_text(provider, result), usage
> +        print(f"\n=3D=3D=3D Tool Use Round {round_num + 1} =3D=3D=3D",
> file=3Dsys.stderr)
> +
> +    # Add assistant message with tool calls
> +    messages.append(message)
> +
> +    # Execute each tool and collect results
> +    tool_messages =3D []
> +    for tool_call in tool_calls:
> +        tool_id =3D tool_call.get("id")
> +        function =3D tool_call.get("function", {})
> +        tool_name =3D function.get("name")
> +        tool_args_str =3D function.get("arguments", "{}")
> +
> +        try:
> +            tool_input =3D json.loads(tool_args_str)
> +        except json.JSONDecodeError:
> +            tool_input =3D {}
> +
> +        if verbose:
> +            print(f"Calling tool: {tool_name}", file=3Dsys.stderr)
> +            print(f"Input: {json.dumps(tool_input, indent=3D2)}",
> file=3Dsys.stderr)
> +
> +        # Execute the tool
> +        try:
> +            from _tools import execute_tool
> +            tool_output =3D execute_tool(tool_name, tool_input)
> +        except Exception as e:
> +            tool_output =3D f"Tool error: {e}"
> +
> +        if verbose:
> +            output_preview =3D tool_output[:200] + "..." if
> len(tool_output) > 200 else tool_output
> +            print(f"Output: {output_preview}", file=3Dsys.stderr)
> +
> +        tool_messages.append({
> +            "role": "tool",
> +            "tool_call_id": tool_id,
> +            "name": tool_name,
> +            "content": tool_output,
> +        })
> +
> +    # Add all tool results as separate messages
> +    messages.extend(tool_messages)
> +    return True
> +
> +
> +def send_request(
> +    provider: str,
> +    auth: str,
> +    model: str,
> +    request_data: dict[str, Any],
> +    *,
> +    timeout: int =3D 120,
> +    verbose: bool =3D False,
> +    enable_tools: bool =3D False,
> +    max_tool_rounds: int =3D 10,
> +) -> tuple[str, TokenUsage]:
> +    """Send a prebuilt request to a provider and return (response_text,
> usage).
> +
> +    The caller assembles the provider-specific request body via its own
> +    build_*_request helpers (the prompts differ per script). This functi=
on
> +    handles transport, error reporting, and token-usage extraction.
> +
> +    If enable_tools is True, implements a tool-use loop where the model
> can
> +    call tools, this function executes them, and sends results back unti=
l
> +    the model returns a text response.
> +
> +    Args:
> +        provider: Provider name (anthropic, openai, xai, google)
> +        auth: Authentication string - either "direct:<api_key>" or
> "vertex"
> +        model: Model identifier
> +        request_data: Provider-specific request payload
> +        timeout: Request timeout in seconds
> +        verbose: Show detailed token usage
> +        enable_tools: Enable tool calling support
> +        max_tool_rounds: Maximum number of tool calling rounds (default:
> 10)
> +
> +    Returns:
> +        Tuple of (response_text, token_usage)
> +    """
> +    # Add tools to request if enabled
> +    if enable_tools:
> +        if provider =3D=3D "anthropic":
> +            from _tools import get_tools_for_provider
> +            request_data["tools"] =3D get_tools_for_provider(provider)
> +        elif provider in ("openai", "xai"):
> +            from _tools import get_tools_for_provider
> +            request_data["tools"] =3D get_tools_for_provider(provider)
> +            # Disable parallel tool calling for OpenAI/xAI (sequential
> execution only)
> +            request_data["parallel_tool_calls"] =3D False
> +        elif provider =3D=3D "google":
> +            # Google Gemini tool calling not yet implemented
> +            if verbose:
> +                print("Warning: Tool calling not yet supported for Googl=
e
> Gemini", file=3Dsys.stderr)
> +            enable_tools =3D False
> +
> +    total_usage =3D TokenUsage()
> +    messages =3D request_data.get("messages", [])
> +
> +    # Tool use loop
> +    for round_num in range(max_tool_rounds):
> +        result =3D _execute_api_call(provider, auth, model, request_data=
,
> timeout)
> +
> +        usage =3D _extract_usage(provider, result)
> +        total_usage.add(usage)
> +
> +        # Check if tools were used
> +        tools_used =3D False
> +        if enable_tools:
> +            if provider =3D=3D "anthropic":
> +                tools_used =3D _handle_anthropic_tool_use(result, messag=
es,
> verbose, round_num)
> +            elif provider in ("openai", "xai"):
> +                tools_used =3D _handle_openai_tool_use(result, messages,
> verbose, round_num)
> +
> +        if not tools_used:
> +            # Final response
> +            if verbose and round_num > 0:
> +                print(f"=3D=3D=3D Tool Use Complete ({round_num} rounds)
> =3D=3D=3D\n", file=3Dsys.stderr)
> +            if verbose:
> +                _print_verbose_usage(total_usage)
> +            return _extract_text(provider, result), total_usage
> +
> +        # Update messages for next round
> +        request_data["messages"] =3D messages
> +
> +    # Max rounds exceeded
> +    if verbose:
> +        print(f"Warning: Max tool rounds ({max_tool_rounds}) exceeded",
> file=3Dsys.stderr)
> +        _print_verbose_usage(total_usage)
> +
> +    # Return whatever we have
> +    return _extract_text(provider, result), total_usage
> diff --git a/devtools/ai/_tools.py b/devtools/ai/_tools.py
> new file mode 100644
> index 0000000000..a74d354982
> --- /dev/null
> +++ b/devtools/ai/_tools.py
> @@ -0,0 +1,674 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 Aaron Conole
> +
> +"""
> +Read-only tool calling support for DPDK AI review scripts.
> +
> +Provides secure, sandboxed tools for AI to gather additional context:
> +- git log: View commit history
> +- git show: View specific commits
> +- grep: Search file contents
> +- awk/sed: Parse and extract text (read-only)
> +- file_read: Read file contents
> +
> +All tools validate paths to prevent escaping the git repository.
> +"""
> +
> +import json
> +import re
> +import subprocess
> +from pathlib import Path
> +from typing import Any, NoReturn
> +
> +
> +class ToolError(Exception):
> +    """Raised when a tool execution fails."""
> +    pass
> +
> +
> +class SecurityError(Exception):
> +    """Raised when a security constraint is violated."""
> +    pass
> +
> +
> +def get_git_root() -> Path:
> +    """Get the root directory of the git repository.
> +
> +    Returns:
> +        Path to the git repository root
> +
> +    Raises:
> +        ToolError: If not in a git repository
> +    """
> +    try:
> +        result =3D subprocess.run(
> +            ["git", "rev-parse", "--show-toplevel"],
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +        )
> +        return Path(result.stdout.strip()).resolve()
> +    except (subprocess.CalledProcessError, FileNotFoundError) as e:
> +        raise ToolError(f"Not in a git repository: {e}") from e
> +
> +
> +def validate_path(path_str: str, git_root: Path) -> Path:
> +    """Validate that a path is within the git repository.
> +
> +    Uses Path.is_relative_to() to prevent directory traversal attacks.
> +
> +    Args:
> +        path_str: Path string to validate
> +        git_root: Root of the git repository
> +
> +    Returns:
> +        Resolved absolute Path object
> +
> +    Raises:
> +        SecurityError: If path escapes the git repository
> +    """
> +    try:
> +        # Convert to absolute path and resolve symlinks
> +        if Path(path_str).is_absolute():
> +            resolved =3D Path(path_str).resolve()
> +        else:
> +            resolved =3D (git_root / path_str).resolve()
> +
> +        # Check if path is within git root
> +        if not resolved.is_relative_to(git_root):
> +            raise SecurityError(
> +                f"Path '{path_str}' escapes git repository root
> '{git_root}'"
> +            )
> +
> +        return resolved
> +
> +    except (ValueError, OSError, RuntimeError) as e:
> +        raise SecurityError(f"Invalid path '{path_str}': {e}") from e
> +
> +
> +def validate_git_ref(ref: str) -> None:
> +    """Validate a git reference (commit hash, branch, tag).
> +
> +    Args:
> +        ref: Git reference to validate
> +
> +    Raises:
> +        SecurityError: If reference contains suspicious characters
> +    """
> +    # Allow alphanumeric, -, _, /, ^, ~, @ (normal git ref characters)
> +    # Disallow command injection characters: ; | & $ ( ) ` < > etc.
> +    if not re.match(r'^[a-zA-Z0-9._/^~@-]+$', ref):
> +        raise SecurityError(f"Invalid git reference: {ref}")
> +
> +
> +def tool_git_log(args: dict[str, Any], git_root: Path) -> str:
> +    """Execute git log with controlled arguments.
> +
> +    Args:
> +        args: Dictionary with optional keys:
> +            - max_count: Maximum number of commits (default: 20, max: 10=
0)
> +            - since: Date/time since (e.g., "2 weeks ago")
> +            - until: Date/time until
> +            - path: File path to filter by
> +            - grep: Commit message grep pattern
> +            - author: Author name/email filter
> +            - oneline: Use oneline format (default: False)
> +
> +    Returns:
> +        Git log output as string
> +
> +    Raises:
> +        ToolError: If git command fails
> +        SecurityError: If validation fails
> +    """
> +    cmd =3D ["git", "log"]
> +
> +    # Validate and add max_count
> +    max_count =3D args.get("max_count", 20)
> +    if not isinstance(max_count, int) or max_count < 1 or max_count > 10=
0:
> +        raise ToolError("max_count must be an integer between 1 and 100"=
)
> +    cmd.extend([f"-{max_count}"])
> +
> +    # Add optional filters
> +    if args.get("oneline"):
> +        cmd.append("--oneline")
> +    else:
> +        cmd.append("--format=3D%H%n%an <%ae>%n%ad%n%s%n%b%n---")
> +
> +    if "since" in args:
> +        cmd.extend(["--since", args["since"]])
> +
> +    if "until" in args:
> +        cmd.extend(["--until", args["until"]])
> +
> +    if "author" in args:
> +        cmd.extend(["--author", args["author"]])
> +
> +    if "grep" in args:
> +        cmd.extend(["--grep", args["grep"]])
> +
> +    # Validate and add path filter
> +    if "path" in args:
> +        path =3D validate_path(args["path"], git_root)
> +        cmd.extend(["--", str(path)])
> +
> +    try:
> +        result =3D subprocess.run(
> +            cmd,
> +            cwd=3Dgit_root,
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +            timeout=3D30,
> +        )
> +        return result.stdout
> +    except subprocess.TimeoutExpired:
> +        raise ToolError("git log timed out after 30 seconds")
> +    except subprocess.CalledProcessError as e:
> +        raise ToolError(f"git log failed: {e.stderr}")
> +
> +
> +def tool_git_show(args: dict[str, Any], git_root: Path) -> str:
> +    """Show a git commit or object.
> +
> +    Args:
> +        args: Dictionary with keys:
> +            - ref: Git reference (commit hash, branch, tag)
> +            - path: Optional path to show specific file at that ref
> +            - stat: Show diffstat only (default: False)
> +
> +    Returns:
> +        Git show output as string
> +
> +    Raises:
> +        ToolError: If git command fails
> +        SecurityError: If validation fails
> +    """
> +    if "ref" not in args:
> +        raise ToolError("ref parameter is required")
> +
> +    ref =3D args["ref"]
> +    validate_git_ref(ref)
> +
> +    cmd =3D ["git", "show"]
> +
> +    if args.get("stat"):
> +        cmd.append("--stat")
> +
> +    # Construct the ref:path or just ref
> +    if "path" in args:
> +        path =3D validate_path(args["path"], git_root)
> +        # Use relative path for git show
> +        rel_path =3D path.relative_to(git_root)
> +        cmd.append(f"{ref}:{rel_path}")
> +    else:
> +        cmd.append(ref)
> +
> +    try:
> +        result =3D subprocess.run(
> +            cmd,
> +            cwd=3Dgit_root,
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +            timeout=3D30,
> +        )
> +        return result.stdout
> +    except subprocess.TimeoutExpired:
> +        raise ToolError("git show timed out after 30 seconds")
> +    except subprocess.CalledProcessError as e:
> +        raise ToolError(f"git show failed: {e.stderr}")
> +
> +
> +def tool_grep(args: dict[str, Any], git_root: Path) -> str:
> +    """Search for pattern in files using grep.
> +
> +    Args:
> +        args: Dictionary with keys:
> +            - pattern: Search pattern (required)
> +            - path: File or directory path (default: current directory)
> +            - recursive: Recursive search (default: True)
> +            - ignore_case: Case-insensitive search (default: False)
> +            - max_count: Maximum matches per file (default: 100)
> +            - context: Lines of context (default: 0)
> +
> +    Returns:
> +        Grep output as string
> +
> +    Raises:
> +        ToolError: If grep fails
> +        SecurityError: If validation fails
> +    """
> +    if "pattern" not in args:
> +        raise ToolError("pattern parameter is required")
> +
> +    pattern =3D args["pattern"]
> +    path =3D validate_path(args.get("path", "."), git_root)
> +
> +    cmd =3D ["grep", "--color=3Dnever"]
> +
> +    if args.get("ignore_case", False):
> +        cmd.append("-i")
> +
> +    if args.get("recursive", True) and path.is_dir():
> +        cmd.append("-r")
> +
> +    max_count =3D args.get("max_count", 100)
> +    if not isinstance(max_count, int) or max_count < 0:
> +       raise ToolError("max_count must be a non-negative integer")
> +    if max_count > 0:
> +        cmd.extend(["-m", str(max_count)])
> +
> +    context =3D args.get("context", 0)
> +    if not isinstance(context, int) or context < 0 or context > 100:
> +        raise ToolError(
> +            "context must be a non-negative integer not greater than 100=
")
> +    cmd.extend(["-C", str(context)])
> +
> +    # Use -- to prevent pattern from being interpreted as an option
> +    cmd.extend(["--", pattern, str(path)])
> +
> +    try:
> +        result =3D subprocess.run(
> +            cmd,
> +            cwd=3Dgit_root,
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            timeout=3D30,
> +        )
> +        # grep returns 1 if no matches, which is not an error
> +        if result.returncode not in (0, 1):
> +            raise ToolError(f"grep failed: {result.stderr}")
> +        return result.stdout
> +    except subprocess.TimeoutExpired:
> +        raise ToolError("grep timed out after 30 seconds")
> +
> +
> +def tool_awk(args: dict[str, Any], git_root: Path) -> str:
> +    """Execute awk for text processing (read-only).
> +
> +    Args:
> +        args: Dictionary with keys:
> +            - program: AWK program (required)
> +            - path: File path (required)
> +
> +    Returns:
> +        AWK output as string
> +
> +    Raises:
> +        ToolError: If awk fails
> +        SecurityError: If validation fails or program attempts writes
> +    """
> +    if "program" not in args or "path" not in args:
> +        raise ToolError("program and path parameters are required")
> +
> +    program =3D args["program"]
> +    path =3D validate_path(args["path"], git_root)
> +
> +    # Security: Disallow dangerous awk features
> +    # Block system(), print/printf redirects, pipes, and getline
> +    dangerous_patterns =3D [
> +        r'system\s*\(',
> +        r'(print|printf)\s*(.*\s*)>\s*',  # any print/printf redirect
> (with/without quotes)
> +        r'(?<![|&])\|(?![|&])\s*', # pipe not preceded/followed by
> another | or &
> +        r'getline',  # all getline operations
> +    ]



I looked into the regex parsing in the tool_awk function, to which I
noticed that the dangerous patterns could be bypassed if the AI passes
forbidden features part by part, for example if "sys" and "tem" are passed
individually, it passes the regex check, but when the command runs it
concatenates the 2 strings resulting in "system" which is forbidden. For
example:

part1 =3D "sys"

part2 =3D "tem"

cmd =3D part1 part2

@cmd("rm -rf /")

If you think this would be an issue, I would recommend looking into awk's
built in '--sandbox' argument, which inherently disables commands such as
system(), getline, pipes, and file redirects.


> +    for pattern in dangerous_patterns:
> +        if re.search(pattern, program):
> +            raise SecurityError(f"AWK program contains forbidden pattern=
:
> {pattern}")
> +
> +    if not path.exists():
> +        raise ToolError(f"File not found: {path}")
> +
> +    cmd =3D ["awk", program, str(path)]
> +
> +    try:
> +        result =3D subprocess.run(
> +            cmd,
> +            cwd=3Dgit_root,
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +            timeout=3D30,
> +        )
> +        return result.stdout
> +    except subprocess.TimeoutExpired:
> +        raise ToolError("awk timed out after 30 seconds")
> +    except subprocess.CalledProcessError as e:
> +        raise ToolError(f"awk failed: {e.stderr}")
> +
> +
> +def tool_sed(args: dict[str, Any], git_root: Path) -> str:
> +    """Execute sed for text processing (read-only).
> +
> +    Args:
> +        args: Dictionary with keys:
> +            - program: sed program (required)
> +            - path: File path (required)
> +
> +    Returns:
> +        sed output as string
> +
> +    Raises:
> +        ToolError: If sed fails
> +        SecurityError: If validation fails or program attempts writes
> +    """
> +    if "program" not in args or "path" not in args:
> +        raise ToolError("program and path parameters are required")
> +
> +    program =3D args["program"]
> +    path =3D validate_path(args["path"], git_root)
> +
> +    # Security: Force read-only mode, disallow write/execute commands
> +    # Block w (write), W (Write), e (execute), r/R (read from file), Q
> (quit with code)
> +    dangerous_patterns =3D [
> +        r'[wWeRQ]\s',  # write, Write, execute, Read, Quit
> +        r'\d+[wWeRQ]$',  # write/execute/read/quit with address
> +        r'[rR][/\s]',  # read from file (with or without whitespace)
> +    ]


When checking for dangerous commands using regex here, I was wondering if
this would affect regular commands that match the patterns? Please correct
me if I'm wrong, but I wanted to make sure that the specified regex
patterns wouldn't block commands that would be useful.

+    for pattern in dangerous_patterns:
> +        if re.search(pattern, program):
> +            raise SecurityError(f"sed program contains forbidden pattern=
:
> {pattern}")
> +
> +    if not path.exists():
> +        raise ToolError(f"File not found: {path}")
> +
> +    # Always use -n (suppress automatic printing) to prevent side effect=
s
> +    cmd =3D ["sed", "-n", program, str(path)]
> +
> +    try:
> +        result =3D subprocess.run(
> +            cmd,
> +            cwd=3Dgit_root,
> +            capture_output=3DTrue,
> +            text=3DTrue,
> +            check=3DTrue,
> +            timeout=3D30,
> +        )
> +        return result.stdout
> +    except subprocess.TimeoutExpired:
> +        raise ToolError("sed timed out after 30 seconds")
> +    except subprocess.CalledProcessError as e:
> +        raise ToolError(f"sed failed: {e.stderr}")
> +
> +
> +def tool_file_read(args: dict[str, Any], git_root: Path) -> str:
> +    """Read contents of a file.
> +
> +    Args:
> +        args: Dictionary with keys:
> +            - path: File path (required)
> +            - max_size: Maximum file size in bytes (default: 1MB)
> +            - encoding: Text encoding (default: utf-8)
> +
> +    Returns:
> +        File contents as string
> +
> +    Raises:
> +        ToolError: If file read fails
> +        SecurityError: If validation fails
> +    """
> +    if "path" not in args:
> +        raise ToolError("path parameter is required")
> +
> +    path =3D validate_path(args["path"], git_root)
> +    max_size =3D args.get("max_size", 1024 * 1024)  # 1MB default
> +    encoding =3D args.get("encoding", "utf-8")
> +
> +    if not path.exists():
> +        raise ToolError(f"File not found: {path}")
> +
> +    if not path.is_file():
> +        raise ToolError(f"Not a file: {path}")
> +
> +    # Check file size
> +    file_size =3D path.stat().st_size
> +    if file_size > max_size:
> +        raise ToolError(
> +            f"File too large: {file_size} bytes (max: {max_size})"
> +        )
> +
> +    try:
> +        # Use errors=3D'replace' to handle non-UTF8 bytes gracefully
> +        return path.read_text(encoding=3Dencoding, errors=3D'replace')
> +    except Exception as e:
> +        raise ToolError(f"Failed to read file: {e}") from e
> +
> +
> +# Tool definitions for Anthropic API
> +TOOL_DEFINITIONS =3D [
> +    {
> +        "name": "git_log",
> +        "description": "View git commit history with optional filters.
> Use this to understand recent changes, find related commits, or trace the
> history of specific files.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "max_count": {
> +                    "type": "integer",
> +                    "description": "Maximum number of commits to show
> (1-100, default: 20)",
> +                    "minimum": 1,
> +                    "maximum": 100,
> +                },
> +                "since": {
> +                    "type": "string",
> +                    "description": "Show commits more recent than date
> (e.g., '2 weeks ago', '2024-01-01')",
> +                },
> +                "until": {
> +                    "type": "string",
> +                    "description": "Show commits older than date",
> +                },
> +                "path": {
> +                    "type": "string",
> +                    "description": "Only show commits affecting this fil=
e
> path",
> +                },
> +                "grep": {
> +                    "type": "string",
> +                    "description": "Only show commits with messages
> matching this pattern",
> +                },
> +                "author": {
> +                    "type": "string",
> +                    "description": "Only show commits by this author",
> +                },
> +                "oneline": {
> +                    "type": "boolean",
> +                    "description": "Use compact one-line format (default=
:
> false)",
> +                },
> +            },
> +        },
> +    },
> +    {
> +        "name": "git_show",
> +        "description": "Show the contents of a git commit or a specific
> file at a given commit. Use this to examine what changed in a specific
> commit or to view historical file contents.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "ref": {
> +                    "type": "string",
> +                    "description": "Git reference (commit hash, branch
> name, tag, or HEAD~N)",
> +                },
> +                "path": {
> +                    "type": "string",
> +                    "description": "Optional: specific file path to show
> at this ref",
> +                },
> +                "stat": {
> +                    "type": "boolean",
> +                    "description": "Show only diffstat (default: false)"=
,
> +                },
> +            },
> +            "required": ["ref"],
> +        },
> +    },
> +    {
> +        "name": "grep",
> +        "description": "Search for text patterns in files. Use this to
> find specific code patterns, function definitions, or configuration
> values.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "pattern": {
> +                    "type": "string",
> +                    "description": "Search pattern (supports regex)",
> +                },
> +                "path": {
> +                    "type": "string",
> +                    "description": "File or directory to search (default=
:
> current directory)",
> +                },
> +                "recursive": {
> +                    "type": "boolean",
> +                    "description": "Search recursively in directories
> (default: true)",
> +                },
> +                "ignore_case": {
> +                    "type": "boolean",
> +                    "description": "Case-insensitive search (default:
> false)",
> +                },
> +                "max_count": {
> +                    "type": "integer",
> +                    "description": "Maximum matches per file (default:
> 100)",
> +                },
> +                "context": {
> +                    "type": "integer",
> +                    "description": "Lines of context around matches
> (default: 0)",
> +                },
> +            },
> +            "required": ["pattern"],
> +        },
> +    },
> +    {
> +        "name": "awk",
> +        "description": "Process text files using AWK (read-only). Use
> this to extract columns, filter lines, or perform text transformations.
> Write/execute operations are blocked.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "program": {
> +                    "type": "string",
> +                    "description": "AWK program to execute",
> +                },
> +                "path": {
> +                    "type": "string",
> +                    "description": "File to process",
> +                },
> +            },
> +            "required": ["program", "path"],
> +        },
> +    },
> +    {
> +        "name": "sed",
> +        "description": "Process text files using sed (read-only). Use
> this to extract or transform text. Write/execute operations are blocked a=
nd
> -n flag is always enabled.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "program": {
> +                    "type": "string",
> +                    "description": "sed program to execute (use p comman=
d
> to print)",
> +                },
> +                "path": {
> +                    "type": "string",
> +                    "description": "File to process",
> +                },
> +            },
> +            "required": ["program", "path"],
> +        },
> +    },
> +    {
> +        "name": "file_read",
> +        "description": "Read the contents of a file. Use this to examine
> source code, documentation, or configuration files.",
> +        "input_schema": {
> +            "type": "object",
> +            "properties": {
> +                "path": {
> +                    "type": "string",
> +                    "description": "Path to the file to read",
> +                },
> +                "max_size": {
> +                    "type": "integer",
> +                    "description": "Maximum file size in bytes (default:
> 1048576 =3D 1MB)",
> +                },
> +                "encoding": {
> +                    "type": "string",
> +                    "description": "Text encoding (default: utf-8)",
> +                },
> +            },
> +            "required": ["path"],
> +        },
> +    },
> +]
> +
> +
> +# Map tool names to handler functions
> +TOOL_HANDLERS =3D {
> +    "git_log": tool_git_log,
> +    "git_show": tool_git_show,
> +    "grep": tool_grep,
> +    "awk": tool_awk,
> +    "sed": tool_sed,
> +    "file_read": tool_file_read,
> +}
> +
> +
> +def execute_tool(tool_name: str, tool_args: dict[str, Any]) -> str:
> +    """Execute a tool and return its output.
> +
> +    Args:
> +        tool_name: Name of the tool to execute
> +        tool_args: Arguments for the tool
> +
> +    Returns:
> +        Tool output as string
> +
> +    Raises:
> +        ToolError: If tool execution fails
> +        SecurityError: If security validation fails
> +    """
> +    if tool_name not in TOOL_HANDLERS:
> +        raise ToolError(f"Unknown tool: {tool_name}")
> +
> +    git_root =3D get_git_root()
> +    handler =3D TOOL_HANDLERS[tool_name]
> +
> +    try:
> +        return handler(tool_args, git_root)
> +    except (ToolError, SecurityError):
> +        raise
> +    except Exception as e:
> +        raise ToolError(f"Tool execution failed: {e}") from e
> +
> +
> +def convert_tools_to_openai_format(anthropic_tools: list[dict[str, Any]]=
)
> -> list[dict[str, Any]]:
> +    """Convert Anthropic tool definitions to OpenAI function calling
> format.
> +
> +    Args:
> +        anthropic_tools: List of tool definitions in Anthropic format
> +
> +    Returns:
> +        List of tool definitions in OpenAI format
> +    """
> +    openai_tools =3D []
> +    for tool in anthropic_tools:
> +        openai_tool =3D {
> +            "type": "function",
> +            "function": {
> +                "name": tool["name"],
> +                "description": tool["description"],
> +                "parameters": tool["input_schema"],
> +            }
> +        }
> +        openai_tools.append(openai_tool)
> +    return openai_tools
> +
> +
> +def get_tools_for_provider(provider: str) -> list[dict[str, Any]]:
> +    """Get tool definitions in the format required by the provider.
> +
> +    Args:
> +        provider: Provider name (anthropic, openai, xai, google)
> +
> +    Returns:
> +        List of tool definitions in provider-specific format
> +    """
> +    if provider =3D=3D "anthropic":
> +        return TOOL_DEFINITIONS
> +    elif provider in ("openai", "xai"):
> +        return convert_tools_to_openai_format(TOOL_DEFINITIONS)
> +    else:
> +        # Google Gemini uses a different format, not yet implemented
> +        return []
> diff --git a/devtools/ai/review-doc.py b/devtools/ai/review-doc.py
> index e01be077fe..a084678ec5 100755
> --- a/devtools/ai/review-doc.py
> +++ b/devtools/ai/review-doc.py
> @@ -360,6 +360,8 @@ def call_api(
>      include_diff_markers: bool =3D False,
>      verbose: bool =3D False,
>      timeout: int =3D 120,
> +    enable_tools: bool =3D True,
> +    max_tool_rounds: int =3D 10,
>  ) -> tuple[str, TokenUsage]:
>      """Build the per-provider request body and dispatch via _common."""
>      if provider =3D=3D "anthropic":
> @@ -399,6 +401,8 @@ def call_api(
>          request_data,
>          timeout=3Dtimeout,
>          verbose=3Dverbose,
> +        enable_tools=3Denable_tools,
> +        max_tool_rounds=3Dmax_tool_rounds,
>      )
>
>
> @@ -665,6 +669,18 @@ def main() -> None:
>          metavar=3D"SECONDS",
>          help=3D"API request timeout in seconds (default: 120)",
>      )
> +    parser.add_argument(
> +        "--no-tools",
> +        action=3D"store_true",
> +        help=3D"Disable tool calling (git, grep, file read). Tools are
> enabled by default.",
> +    )
> +    parser.add_argument(
> +        "--max-tool-rounds",
> +        type=3Dint,
> +        default=3D10,
> +        metavar=3D"N",
> +        help=3D"Maximum tool calling rounds (default: 10)",
> +    )
>
>      # Email options
>      email_group =3D parser.add_argument_group("Email Options")
> @@ -811,6 +827,8 @@ def main() -> None:
>              args.diff,
>              args.verbose,
>              args.timeout,
> +            enable_tools=3Dnot args.no_tools,
> +            max_tool_rounds=3Dargs.max_tool_rounds,
>          )
>          total_usage.add(call_usage)
>
> diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py
> index 5f8d9ed772..a3481290be 100755
> --- a/devtools/ai/review-patch.py
> +++ b/devtools/ai/review-patch.py
> @@ -589,6 +589,8 @@ def call_api(
>      output_format: str =3D "text",
>      verbose: bool =3D False,
>      timeout: int =3D 300,
> +    enable_tools: bool =3D True,
> +    max_tool_rounds: int =3D 10,
>  ) -> tuple[str, TokenUsage]:
>      """Build the per-provider request body and dispatch via _common."""
>      if provider =3D=3D "anthropic":
> @@ -625,6 +627,8 @@ def call_api(
>          request_data,
>          timeout=3Dtimeout,
>          verbose=3Dverbose,
> +        enable_tools=3Denable_tools,
> +        max_tool_rounds=3Dmax_tool_rounds,
>      )
>
>
> @@ -870,6 +874,18 @@ def main() -> None:
>          metavar=3D"SECONDS",
>          help=3D"API request timeout in seconds (default: 300)",
>      )
> +    parser.add_argument(
> +        "--no-tools",
> +        action=3D"store_true",
> +        help=3D"Disable tool calling (git, grep, file read). Tools are
> enabled by default.",
> +    )
> +    parser.add_argument(
> +        "--max-tool-rounds",
> +        type=3Dint,
> +        default=3D10,
> +        metavar=3D"N",
> +        help=3D"Maximum tool calling rounds (default: 10)",
> +    )
>
>      # Date and release options
>      parser.add_argument(
> @@ -1079,6 +1095,8 @@ def main() -> None:
>                      args.output_format,
>                      args.verbose,
>                      args.timeout,
> +                    enable_tools=3Dnot args.no_tools,
> +                    max_tool_rounds=3Dargs.max_tool_rounds,
>                  )
>                  total_usage.add(call_usage)
>                  all_reviews.append((patch_label, review_text))
> @@ -1149,6 +1167,8 @@ def main() -> None:
>                      args.output_format,
>                      args.verbose,
>                      args.timeout,
> +                    enable_tools=3Dnot args.no_tools,
> +                    max_tool_rounds=3Dargs.max_tool_rounds,
>                  )
>                  total_usage.add(call_usage)
>                  all_reviews.append((chunk_label, review_text))
> @@ -1203,6 +1223,8 @@ def main() -> None:
>              args.output_format,
>              args.verbose,
>              args.timeout,
> +            enable_tools=3Dnot args.no_tools,
> +            max_tool_rounds=3Dargs.max_tool_rounds,
>          )
>          total_usage.add(call_usage)
>
> --
> 2.55.0
>
>

--000000000000409621065d588970
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Aaron,</div><div><br></div><div>T=
hank=C2=A0you for this patch. After looking at the code and testing the AI =
code review, there&#39;s a few things I wanted to bring up.</div><div>First=
ly, I&#39;ve noticed that the tool calling has been inconsistent. I ran the=
 review on the AI tools patch=C2=A0without an Agents.md file, to which the =
AI ran a few tools and successfully gave me an output. However, when I ran =
it a few times after, regardless of providing the Agents.md file I was seei=
ng no tool calls run. Could this be because=C2=A0the AI decided it had enou=
gh context to not need to invoke tools, or maybe even the AI does not know =
it has access to these tools/when to invoke them?</div><div>I&#39;ve also r=
un it using Haiku 5.5, to which=C2=A0the AI tried a file_read tool call to =
read the patch, was unable to locate the file, but still went on to review =
the patch as shown:<br><br><span id=3D"m_-4015722872033445661gmail-docs-int=
ernal-guid-273cda43-7fff-c246-8360-3ba462cf1c8c"><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span></p><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><b style=3D"font-weight:normal" id=3D"m_-40=
15722872033445661gmail-docs-internal-guid-7a2f1ef0-7fff-3a70-853d-82f6442dc=
d93"><br></b></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:n=
ormal;font-variant:normal;text-decoration:none;vertical-align:baseline;whit=
e-space:pre-wrap">=3D=3D=3D Tool Use Round 1 =3D=3D=3D</span></p><p dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-weight:400;font-style:normal;font-variant:normal;t=
ext-decoration:none;vertical-align:baseline;white-space:pre-wrap">Calling t=
ool: file_read</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sa=
ns-serif;color:rgb(0,0,0);background-color:transparent;font-weight:400;font=
-style:normal;font-variant:normal;text-decoration:none;vertical-align:basel=
ine;white-space:pre-wrap">Input: {</span></p><p dir=3D"ltr" style=3D"line-h=
eight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;=
vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0&quot;path&quot;:=
 &quot;RFC-dts-resolve-trex-driver-binding-issue.patch&quot;</span></p><p d=
ir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><spa=
n style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);bac=
kground-color:transparent;font-weight:400;font-style:normal;font-variant:no=
rmal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">}</=
span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:r=
gb(0,0,0);background-color:transparent;font-weight:400;font-style:normal;fo=
nt-variant:normal;text-decoration:none;vertical-align:baseline;white-space:=
pre-wrap">Output: Tool error: File not found: /home/knimoji/repos/dpdk-next=
-dts/RFC-dts-resolve-trex-driver-binding-issue.patch</span></p><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-weight:400;font-style:normal;font-variant:normal;te=
xt-decoration:none;vertical-align:baseline;white-space:pre-wrap">Error occu=
rred</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:nor=
mal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-=
space:pre-wrap">=3D=3D=3D Tool Use Complete (1 rounds) =3D=3D=3D</span></p>=
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">=
<b style=3D"font-weight:normal"><br></b></p><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;f=
ont-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;f=
ont-weight:400;font-style:normal;font-variant:normal;text-decoration:none;v=
ertical-align:baseline;white-space:pre-wrap">=3D=3D=3D Token Usage =3D=3D=
=3D</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-weight:400;font-style:norm=
al;font-variant:normal;text-decoration:none;vertical-align:baseline;white-s=
pace:pre-wrap">Input tokens: 29,377</span></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none=
;vertical-align:baseline;white-space:pre-wrap">Output tokens: 2,428</span><=
/p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0p=
t"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0=
,0);background-color:transparent;font-weight:400;font-style:normal;font-var=
iant:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wr=
ap">Cache creation: 22,984</span></p><p dir=3D"ltr" style=3D"line-height:1.=
38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fam=
ily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-wei=
ght:400;font-style:normal;font-variant:normal;text-decoration:none;vertical=
-align:baseline;white-space:pre-wrap">Cache read: 22,984</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:transparent;font-weight:400;font-style:normal;font-variant:norm=
al;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></p><p dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-weight:400;font-style:normal;font-variant:normal;t=
ext-decoration:none;vertical-align:baseline;white-space:pre-wrap">=3D=3D=3D=
 Patch Review: RFC-dts-resolve-trex-driver-binding-issue.patch (via Claude)=
 =3D=3D=3D</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0p=
t;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-s=
erif;color:rgb(0,0,0);background-color:transparent;font-weight:400;font-sty=
le:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;=
white-space:pre-wrap">Review date: 2026-10-08</span></p><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><b style=3D"font-we=
ight:normal"><br></b></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sa=
ns-serif;color:rgb(0,0,0);background-color:transparent;font-weight:400;font=
-style:normal;font-variant:normal;text-decoration:none;vertical-align:basel=
ine;white-space:pre-wrap">I&#39;ll work with the patch content you&#39;ve p=
rovided directly. Let me analyze it systematically.</span></p><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><b style=3D"f=
ont-weight:normal"><br></b></p><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Ar=
ial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight:40=
0;font-style:normal;font-variant:normal;text-decoration:none;vertical-align=
:baseline;white-space:pre-wrap">## DPDK Code Review: RFC-dts-resolve-trex-d=
river-binding-issue.patch</span></p><p dir=3D"ltr" style=3D"line-height:1.3=
8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fami=
ly:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-weig=
ht:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-=
align:baseline;white-space:pre-wrap">...</span></p></span></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 20=
26 at 10:14=E2=80=AFAM Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.co=
m" target=3D"_blank">aconole@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Add an iterative tool-use loop to re=
view-patch.py and review-doc.py<br>
for Anthropic, OpenAI, and xAI providers. The AI reviewer can now<br>
look up additional context from the DPDK source tree when the patch<br>
or document alone is insufficient, rather than having to guess at<br>
surrounding code, API contracts, commit history, or function<br>
signatures.<br>
<br>
Tool calling is enabled by default with a configurable limit<br>
(default: 10 rounds). Pass &#39;--no-tools&#39; to disable it and restore<b=
r>
the previous single-shot behavior, or &#39;--max-tool-rounds N&#39; to<br>
adjust the limit. The round limit prevents runaway execution on<br>
complex reviews; when reached, the model delivers a final response<br>
with the context gathered so far.<br>
<br>
Tool set (_tools.py):<br>
=C2=A0 - git_log=C2=A0 =C2=A0 =C2=A0 =C2=A0 View commit history with option=
al filters (author,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0date r=
ange, path, message grep)<br>
=C2=A0 - git_show=C2=A0 =C2=A0 =C2=A0 =C2=A0Display specific commits or fil=
e contents at a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0given =
ref, with optional diffstat<br>
=C2=A0 - grep=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Search for regex patt=
erns across files with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config=
urable recursion, case sensitivity, match<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0limits=
, and context lines<br>
=C2=A0 - awk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Process text with AWK=
 programs (read-only, blocks<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system=
(), file writes, and command execution)<br>
=C2=A0 - sed=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Process text with sed=
 programs (read-only, -n mode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enforc=
ed, blocks write/execute/read commands)<br>
=C2=A0 - file_read=C2=A0 =C2=A0 =C2=A0 Read file contents up to a configura=
ble size limit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(defau=
lt 1MB) with encoding support<br>
<br>
All tools validate paths using Path().is_relative_to() to prevent<br>
directory traversal attacks. Tools are confined to the git repository<br>
root and include 30-second timeouts to prevent hanging.<br>
<br>
The _common.py send_request() function now handles the tool-calling<br>
loop for supported providers, inspecting stop_reason (Anthropic) or<br>
finish_reason (OpenAI/xAI) to determine if tool execution is needed,<br>
then converting tool definitions between provider formats as required.<br>
<br>
Assisted-by: Claude:sonnet-4.5<br>
Signed-off-by: Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.com" targe=
t=3D"_blank">aconole@redhat.com</a>&gt;<br>
---<br>
RFC -&gt; PATCH:<br>
=C2=A0 - More (read-only) tools<br>
=C2=A0 - Resolve (most?) security escapes<br>
=C2=A0 - xAI support (since it is openAI compatible)<br>
<br>
=C2=A0devtools/ai/_common.py=C2=A0 =C2=A0 =C2=A0 | 273 +++++++++++++--<br>
=C2=A0devtools/ai/_tools.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 674 +++++++++++++++=
+++++++++++++++++++++<br>
=C2=A0devtools/ai/review-doc.py=C2=A0 =C2=A0|=C2=A0 18 +<br>
=C2=A0devtools/ai/review-patch.py |=C2=A0 22 ++<br>
=C2=A04 files changed, 966 insertions(+), 21 deletions(-)<br>
=C2=A0create mode 100644 devtools/ai/_tools.py<br>
<br>
diff --git a/devtools/ai/_common.py b/devtools/ai/_common.py<br>
index 07a0411aaf..bdbc91034f 100644<br>
--- a/devtools/ai/_common.py<br>
+++ b/devtools/ai/_common.py<br>
@@ -369,39 +369,35 @@ def _print_verbose_usage(usage: TokenUsage) -&gt; Non=
e:<br>
=C2=A0 =C2=A0 =C2=A0print(&quot;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D&quot;, file=3Dsys.stderr)<br>
<br>
<br>
-def send_request(<br>
+def _execute_api_call(<br>
=C2=A0 =C2=A0 =C2=A0provider: str,<br>
=C2=A0 =C2=A0 =C2=A0auth: str,<br>
=C2=A0 =C2=A0 =C2=A0model: str,<br>
=C2=A0 =C2=A0 =C2=A0request_data: dict[str, Any],<br>
-=C2=A0 =C2=A0 *,<br>
-=C2=A0 =C2=A0 timeout: int =3D 120,<br>
-=C2=A0 =C2=A0 verbose: bool =3D False,<br>
-) -&gt; tuple[str, TokenUsage]:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Send a prebuilt request to a provider and =
return (response_text, usage).<br>
-<br>
-=C2=A0 =C2=A0 The caller assembles the provider-specific request body via =
its own<br>
-=C2=A0 =C2=A0 build_*_request helpers (the prompts differ per script). Thi=
s function<br>
-=C2=A0 =C2=A0 handles transport, error reporting, and token-usage extracti=
on.<br>
+=C2=A0 =C2=A0 timeout: int,<br>
+) -&gt; dict[str, Any]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Execute a single API call and return the r=
esult.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 provider: Provider name (anthropic, openai, xa=
i, google)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth: Authentication string - either &quot;dir=
ect:&lt;api_key&gt;&quot; or &quot;vertex&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 provider: Provider name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth: Authentication string<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0model: Model identifier<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data: Provider-specific request payloa=
d<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data: Request payload<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout: Request timeout in seconds<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose: Show detailed token usage<br>
<br>
=C2=A0 =C2=A0 =C2=A0Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuple of (response_text, token_usage)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 API response as dictionary<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Calls error() on failure (does not return)<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 url, headers, request_data =3D _build_request_meta(provider,=
 auth, model, request_data)<br>
-=C2=A0 =C2=A0 body =3D json.dumps(request_data).encode(&quot;utf-8&quot;)<=
br>
+=C2=A0 =C2=A0 url, headers, req_data =3D _build_request_meta(provider, aut=
h, model, request_data)<br>
+=C2=A0 =C2=A0 body =3D json.dumps(req_data).encode(&quot;utf-8&quot;)<br>
=C2=A0 =C2=A0 =C2=A0req =3D Request(url, data=3Dbody, headers=3Dheaders)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with urlopen(req, timeout=3Dtimeout) as r=
esponse:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D json.loads(response.r=
ead().decode(&quot;utf-8&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return json.loads(response.read(=
).decode(&quot;utf-8&quot;))<br>
=C2=A0 =C2=A0 =C2=A0except HTTPError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_body =3D e.read().decode(&quot;utf-=
8&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
@@ -421,7 +417,242 @@ def send_request(<br>
=C2=A0 =C2=A0 =C2=A0except TimeoutError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(f&quot;Request timed out after {tim=
eout} seconds&quot;)<br>
<br>
-=C2=A0 =C2=A0 usage =3D _extract_usage(provider, result)<br>
+<br>
+def _handle_anthropic_tool_use(<br>
+=C2=A0 =C2=A0 result: dict[str, Any],<br>
+=C2=A0 =C2=A0 messages: list[dict[str, Any]],<br>
+=C2=A0 =C2=A0 verbose: bool,<br>
+=C2=A0 =C2=A0 round_num: int,<br>
+) -&gt; bool:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Handle Anthropic tool use response.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result: API response<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 messages: Message history (modified in place)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose: Print debug info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 round_num: Current round number (for logging)<=
br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 True if tools were used, False otherwise<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 stop_reason =3D result.get(&quot;stop_reason&quot;)<br>
+=C2=A0 =C2=A0 if stop_reason !=3D &quot;tool_use&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from _tools import execute_tool<br>
+=C2=A0 =C2=A0 except ImportError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def execute_tool(tool_name, tool_input):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise RuntimeError(f&quot;Cannot=
 run {tool_name} - bad _tools.py&quot;)<br>
+<br>
+=C2=A0 =C2=A0 content_blocks =3D result.get(&quot;content&quot;, [])<br>
+=C2=A0 =C2=A0 tool_results =3D []<br>
+<br>
+=C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;\n=3D=3D=3D Tool Use Round {round=
_num + 1} =3D=3D=3D&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 for block in content_blocks:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if block.get(&quot;type&quot;) =3D=3D &quot;to=
ol_use&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_name =3D block.get(&quot;na=
me&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_input =3D block.get(&quot;i=
nput&quot;, {})<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_use_id =3D block.get(&quot;=
id&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Calli=
ng tool: {tool_name}&quot;, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Input=
: {json.dumps(tool_input, indent=3D2)}&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute the tool<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_output =3D ex=
ecute_tool(tool_name, tool_input)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_error =3D False=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_output =3D f&=
quot;Tool error: {e}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_error =3D True<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output_preview =3D=
 tool_output[:200] + &quot;...&quot; if len(tool_output) &gt; 200 else tool=
_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Outpu=
t: {output_preview}&quot;, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t(f&quot;Error occurred&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_results.append({<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: =
&quot;tool_result&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tool_use_id&=
quot;: tool_use_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;content&quot=
;: tool_output,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;is_error&quo=
t;: is_error,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 })<br>
+<br>
+=C2=A0 =C2=A0 # Add assistant message with tool use<br>
+=C2=A0 =C2=A0 messages.append({<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;role&quot;: &quot;assistant&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;content&quot;: content_blocks,<br>
+=C2=A0 =C2=A0 })<br>
+<br>
+=C2=A0 =C2=A0 # Add user message with tool results<br>
+=C2=A0 =C2=A0 messages.append({<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;role&quot;: &quot;user&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;content&quot;: tool_results,<br>
+=C2=A0 =C2=A0 })<br>
+<br>
+=C2=A0 =C2=A0 return True<br>
+<br>
+<br>
+def _handle_openai_tool_use(<br>
+=C2=A0 =C2=A0 result: dict[str, Any],<br>
+=C2=A0 =C2=A0 messages: list[dict[str, Any]],<br>
+=C2=A0 =C2=A0 verbose: bool,<br>
+=C2=A0 =C2=A0 round_num: int,<br>
+) -&gt; bool:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Handle OpenAI/xAI tool use response.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result: API response<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 messages: Message history (modified in place)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose: Print debug info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 round_num: Current round number (for logging)<=
br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 True if tools were used, False otherwise<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 choices =3D result.get(&quot;choices&quot;, [])<br>
+=C2=A0 =C2=A0 if not choices:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 message =3D choices[0].get(&quot;message&quot;, {})<br>
+=C2=A0 =C2=A0 tool_calls =3D message.get(&quot;tool_calls&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if not tool_calls:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if verbose:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 _print_verbose_usage(usage)<br>
-=C2=A0 =C2=A0 return _extract_text(provider, result), usage<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;\n=3D=3D=3D Tool Use Round {round=
_num + 1} =3D=3D=3D&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 # Add assistant message with tool calls<br>
+=C2=A0 =C2=A0 messages.append(message)<br>
+<br>
+=C2=A0 =C2=A0 # Execute each tool and collect results<br>
+=C2=A0 =C2=A0 tool_messages =3D []<br>
+=C2=A0 =C2=A0 for tool_call in tool_calls:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_id =3D tool_call.get(&quot;id&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 function =3D tool_call.get(&quot;function&quot=
;, {})<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_name =3D function.get(&quot;name&quot;)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_args_str =3D function.get(&quot;arguments=
&quot;, &quot;{}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_input =3D json.loads(tool_a=
rgs_str)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except json.JSONDecodeError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_input =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Calling tool: {tool=
_name}&quot;, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Input: {json.dumps(=
tool_input, indent=3D2)}&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute the tool<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from _tools import execute_tool<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_output =3D execute_tool(too=
l_name, tool_input)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_output =3D f&quot;Tool erro=
r: {e}&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output_preview =3D tool_output[:=
200] + &quot;...&quot; if len(tool_output) &gt; 200 else tool_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Output: {output_pre=
view}&quot;, file=3Dsys.stderr)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_messages.append({<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;role&quot;: &quot;tool&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tool_call_id&quot;: tool_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: tool_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;content&quot;: tool_output=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 })<br>
+<br>
+=C2=A0 =C2=A0 # Add all tool results as separate messages<br>
+=C2=A0 =C2=A0 messages.extend(tool_messages)<br>
+=C2=A0 =C2=A0 return True<br>
+<br>
+<br>
+def send_request(<br>
+=C2=A0 =C2=A0 provider: str,<br>
+=C2=A0 =C2=A0 auth: str,<br>
+=C2=A0 =C2=A0 model: str,<br>
+=C2=A0 =C2=A0 request_data: dict[str, Any],<br>
+=C2=A0 =C2=A0 *,<br>
+=C2=A0 =C2=A0 timeout: int =3D 120,<br>
+=C2=A0 =C2=A0 verbose: bool =3D False,<br>
+=C2=A0 =C2=A0 enable_tools: bool =3D False,<br>
+=C2=A0 =C2=A0 max_tool_rounds: int =3D 10,<br>
+) -&gt; tuple[str, TokenUsage]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Send a prebuilt request to a provider and =
return (response_text, usage).<br>
+<br>
+=C2=A0 =C2=A0 The caller assembles the provider-specific request body via =
its own<br>
+=C2=A0 =C2=A0 build_*_request helpers (the prompts differ per script). Thi=
s function<br>
+=C2=A0 =C2=A0 handles transport, error reporting, and token-usage extracti=
on.<br>
+<br>
+=C2=A0 =C2=A0 If enable_tools is True, implements a tool-use loop where th=
e model can<br>
+=C2=A0 =C2=A0 call tools, this function executes them, and sends results b=
ack until<br>
+=C2=A0 =C2=A0 the model returns a text response.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 provider: Provider name (anthropic, openai, xa=
i, google)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth: Authentication string - either &quot;dir=
ect:&lt;api_key&gt;&quot; or &quot;vertex&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 model: Model identifier<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data: Provider-specific request payloa=
d<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout: Request timeout in seconds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose: Show detailed token usage<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools: Enable tool calling support<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_tool_rounds: Maximum number of tool callin=
g rounds (default: 10)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuple of (response_text, token_usage)<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 # Add tools to request if enabled<br>
+=C2=A0 =C2=A0 if enable_tools:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if provider =3D=3D &quot;anthropic&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from _tools import get_tools_for=
_provider<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data[&quot;tools&quot;] =
=3D get_tools_for_provider(provider)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif provider in (&quot;openai&quot;, &quot;xa=
i&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from _tools import get_tools_for=
_provider<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data[&quot;tools&quot;] =
=3D get_tools_for_provider(provider)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable parallel tool calling =
for OpenAI/xAI (sequential execution only)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data[&quot;parallel_tool=
_calls&quot;] =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif provider =3D=3D &quot;google&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Google Gemini tool calling not=
 yet implemented<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Warnin=
g: Tool calling not yet supported for Google Gemini&quot;, file=3Dsys.stder=
r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools =3D False<br>
+<br>
+=C2=A0 =C2=A0 total_usage =3D TokenUsage()<br>
+=C2=A0 =C2=A0 messages =3D request_data.get(&quot;messages&quot;, [])<br>
+<br>
+=C2=A0 =C2=A0 # Tool use loop<br>
+=C2=A0 =C2=A0 for round_num in range(max_tool_rounds):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D _execute_api_call(provider, auth, m=
odel, request_data, timeout)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usage =3D _extract_usage(provider, result)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 total_usage.add(usage)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Check if tools were used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tools_used =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable_tools:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if provider =3D=3D &quot;anthrop=
ic&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tools_used =3D _ha=
ndle_anthropic_tool_use(result, messages, verbose, round_num)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif provider in (&quot;openai&q=
uot;, &quot;xai&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tools_used =3D _ha=
ndle_openai_tool_use(result, messages, verbose, round_num)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not tools_used:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Final response<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose and round_num &gt; 0:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;=3D=
=3D=3D Tool Use Complete ({round_num} rounds) =3D=3D=3D\n&quot;, file=3Dsys=
.stderr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _print_verbose_usa=
ge(total_usage)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return _extract_text(provider, r=
esult), total_usage<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Update messages for next round<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request_data[&quot;messages&quot;] =3D message=
s<br>
+<br>
+=C2=A0 =C2=A0 # Max rounds exceeded<br>
+=C2=A0 =C2=A0 if verbose:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Warning: Max tool rounds ({max_to=
ol_rounds}) exceeded&quot;, file=3Dsys.stderr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _print_verbose_usage(total_usage)<br>
+<br>
+=C2=A0 =C2=A0 # Return whatever we have<br>
+=C2=A0 =C2=A0 return _extract_text(provider, result), total_usage<br>
diff --git a/devtools/ai/_tools.py b/devtools/ai/_tools.py<br>
new file mode 100644<br>
index 0000000000..a74d354982<br>
--- /dev/null<br>
+++ b/devtools/ai/_tools.py<br>
@@ -0,0 +1,674 @@<br>
+#!/usr/bin/env python3<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2026 Aaron Conole<br>
+<br>
+&quot;&quot;&quot;<br>
+Read-only tool calling support for DPDK AI review scripts.<br>
+<br>
+Provides secure, sandboxed tools for AI to gather additional context:<br>
+- git log: View commit history<br>
+- git show: View specific commits<br>
+- grep: Search file contents<br>
+- awk/sed: Parse and extract text (read-only)<br>
+- file_read: Read file contents<br>
+<br>
+All tools validate paths to prevent escaping the git repository.<br>
+&quot;&quot;&quot;<br>
+<br>
+import json<br>
+import re<br>
+import subprocess<br>
+from pathlib import Path<br>
+from typing import Any, NoReturn<br>
+<br>
+<br>
+class ToolError(Exception):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Raised when a tool execution fails.&quot;&=
quot;&quot;<br>
+=C2=A0 =C2=A0 pass<br>
+<br>
+<br>
+class SecurityError(Exception):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Raised when a security constraint is viola=
ted.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 pass<br>
+<br>
+<br>
+def get_git_root() -&gt; Path:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Get the root directory of the git reposito=
ry.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Path to the git repository root<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If not in a git repository<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&quot;git&quot;, &quot;rev-pars=
e&quot;, &quot;--show-toplevel&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return Path(result.stdout.strip()).resolve()<b=
r>
+=C2=A0 =C2=A0 except (subprocess.CalledProcessError, FileNotFoundError) as=
 e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;Not in a git repository=
: {e}&quot;) from e<br>
+<br>
+<br>
+def validate_path(path_str: str, git_root: Path) -&gt; Path:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Validate that a path is within the git rep=
ository.<br>
+<br>
+=C2=A0 =C2=A0 Uses Path.is_relative_to() to prevent directory traversal at=
tacks.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path_str: Path string to validate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 git_root: Root of the git repository<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Resolved absolute Path object<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If path escapes the git reposit=
ory<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Convert to absolute path and resolve symlink=
s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if Path(path_str).is_absolute():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resolved =3D Path(path_str).reso=
lve()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resolved =3D (git_root / path_st=
r).resolve()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Check if path is within git root<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not resolved.is_relative_to(git_root):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SecurityError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Path &#39;{=
path_str}&#39; escapes git repository root &#39;{git_root}&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return resolved<br>
+<br>
+=C2=A0 =C2=A0 except (ValueError, OSError, RuntimeError) as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SecurityError(f&quot;Invalid path &#39;{=
path_str}&#39;: {e}&quot;) from e<br>
+<br>
+<br>
+def validate_git_ref(ref: str) -&gt; None:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Validate a git reference (commit hash, bra=
nch, tag).<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ref: Git reference to validate<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If reference contains suspiciou=
s characters<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 # Allow alphanumeric, -, _, /, ^, ~, @ (normal git ref chara=
cters)<br>
+=C2=A0 =C2=A0 # Disallow command injection characters: ; | &amp; $ ( ) ` &=
lt; &gt; etc.<br>
+=C2=A0 =C2=A0 if not re.match(r&#39;^[a-zA-Z0-9._/^~@-]+$&#39;, ref):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SecurityError(f&quot;Invalid git referen=
ce: {ref}&quot;)<br>
+<br>
+<br>
+def tool_git_log(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Execute git log with controlled arguments.=
<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with optional keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - max_count: Maximum number of c=
ommits (default: 20, max: 100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - since: Date/time since (e.g., =
&quot;2 weeks ago&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - until: Date/time until<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: File path to filter by<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - grep: Commit message grep patt=
ern<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - author: Author name/email filt=
er<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - oneline: Use oneline format (d=
efault: False)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Git log output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If git command fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 cmd =3D [&quot;git&quot;, &quot;log&quot;]<br>
+<br>
+=C2=A0 =C2=A0 # Validate and add max_count<br>
+=C2=A0 =C2=A0 max_count =3D args.get(&quot;max_count&quot;, 20)<br>
+=C2=A0 =C2=A0 if not isinstance(max_count, int) or max_count &lt; 1 or max=
_count &gt; 100:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;max_count must be an int=
eger between 1 and 100&quot;)<br>
+=C2=A0 =C2=A0 cmd.extend([f&quot;-{max_count}&quot;])<br>
+<br>
+=C2=A0 =C2=A0 # Add optional filters<br>
+=C2=A0 =C2=A0 if args.get(&quot;oneline&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(&quot;--oneline&quot;)<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(&quot;--format=3D%H%n%an &lt;%ae&gt=
;%n%ad%n%s%n%b%n---&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if &quot;since&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;--since&quot;, args[&quot;si=
nce&quot;]])<br>
+<br>
+=C2=A0 =C2=A0 if &quot;until&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;--until&quot;, args[&quot;un=
til&quot;]])<br>
+<br>
+=C2=A0 =C2=A0 if &quot;author&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;--author&quot;, args[&quot;a=
uthor&quot;]])<br>
+<br>
+=C2=A0 =C2=A0 if &quot;grep&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;--grep&quot;, args[&quot;gre=
p&quot;]])<br>
+<br>
+=C2=A0 =C2=A0 # Validate and add path filter<br>
+=C2=A0 =C2=A0 if &quot;path&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D validate_path(args[&quot;path&quot;],=
 git_root)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;--&quot;, str(path)])<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dgit_root,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3D30,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result.stdout<br>
+=C2=A0 =C2=A0 except subprocess.TimeoutExpired:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;git log timed out after =
30 seconds&quot;)<br>
+=C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;git log failed: {e.stde=
rr}&quot;)<br>
+<br>
+<br>
+def tool_git_show(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Show a git commit or object.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - ref: Git reference (commit has=
h, branch, tag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: Optional path to show sp=
ecific file at that ref<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - stat: Show diffstat only (defa=
ult: False)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Git show output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If git command fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if &quot;ref&quot; not in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;ref parameter is require=
d&quot;)<br>
+<br>
+=C2=A0 =C2=A0 ref =3D args[&quot;ref&quot;]<br>
+=C2=A0 =C2=A0 validate_git_ref(ref)<br>
+<br>
+=C2=A0 =C2=A0 cmd =3D [&quot;git&quot;, &quot;show&quot;]<br>
+<br>
+=C2=A0 =C2=A0 if args.get(&quot;stat&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(&quot;--stat&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Construct the ref:path or just ref<br>
+=C2=A0 =C2=A0 if &quot;path&quot; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D validate_path(args[&quot;path&quot;],=
 git_root)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use relative path for git show<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rel_path =3D path.relative_to(git_root)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(f&quot;{ref}:{rel_path}&quot;)<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(ref)<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dgit_root,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3D30,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result.stdout<br>
+=C2=A0 =C2=A0 except subprocess.TimeoutExpired:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;git show timed out after=
 30 seconds&quot;)<br>
+=C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;git show failed: {e.std=
err}&quot;)<br>
+<br>
+<br>
+def tool_grep(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Search for pattern in files using grep.<br=
>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - pattern: Search pattern (requi=
red)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: File or directory path (=
default: current directory)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - recursive: Recursive search (d=
efault: True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - ignore_case: Case-insensitive =
search (default: False)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - max_count: Maximum matches per=
 file (default: 100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - context: Lines of context (def=
ault: 0)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Grep output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If grep fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if &quot;pattern&quot; not in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;pattern parameter is req=
uired&quot;)<br>
+<br>
+=C2=A0 =C2=A0 pattern =3D args[&quot;pattern&quot;]<br>
+=C2=A0 =C2=A0 path =3D validate_path(args.get(&quot;path&quot;, &quot;.&qu=
ot;), git_root)<br>
+<br>
+=C2=A0 =C2=A0 cmd =3D [&quot;grep&quot;, &quot;--color=3Dnever&quot;]<br>
+<br>
+=C2=A0 =C2=A0 if args.get(&quot;ignore_case&quot;, False):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(&quot;-i&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if args.get(&quot;recursive&quot;, True) and path.is_dir():<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.append(&quot;-r&quot;)<br>
+<br>
+=C2=A0 =C2=A0 max_count =3D args.get(&quot;max_count&quot;, 100)<br>
+=C2=A0 =C2=A0 if not isinstance(max_count, int) or max_count &lt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raise ToolError(&quot;max_count must be a non-n=
egative integer&quot;)<br>
+=C2=A0 =C2=A0 if max_count &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd.extend([&quot;-m&quot;, str(max_count)])<b=
r>
+<br>
+=C2=A0 =C2=A0 context =3D args.get(&quot;context&quot;, 0)<br>
+=C2=A0 =C2=A0 if not isinstance(context, int) or context &lt; 0 or context=
 &gt; 100:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;context must be a non-nega=
tive integer not greater than 100&quot;)<br>
+=C2=A0 =C2=A0 cmd.extend([&quot;-C&quot;, str(context)])<br>
+<br>
+=C2=A0 =C2=A0 # Use -- to prevent pattern from being interpreted as an opt=
ion<br>
+=C2=A0 =C2=A0 cmd.extend([&quot;--&quot;, pattern, str(path)])<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dgit_root,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3D30,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # grep returns 1 if no matches, which is not a=
n error<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if result.returncode not in (0, 1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;grep fail=
ed: {result.stderr}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result.stdout<br>
+=C2=A0 =C2=A0 except subprocess.TimeoutExpired:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;grep timed out after 30 =
seconds&quot;)<br>
+<br>
+<br>
+def tool_awk(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Execute awk for text processing (read-only=
).<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - program: AWK program (required=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: File path (required)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AWK output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If awk fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails or program =
attempts writes<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if &quot;program&quot; not in args or &quot;path&quot; not i=
n args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;program and path paramet=
ers are required&quot;)<br>
+<br>
+=C2=A0 =C2=A0 program =3D args[&quot;program&quot;]<br>
+=C2=A0 =C2=A0 path =3D validate_path(args[&quot;path&quot;], git_root)<br>
+<br>
+=C2=A0 =C2=A0 # Security: Disallow dangerous awk features<br>
+=C2=A0 =C2=A0 # Block system(), print/printf redirects, pipes, and getline=
<br>
+=C2=A0 =C2=A0 dangerous_patterns =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;system\s*\(&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;(print|printf)\s*(.*\s*)&gt;\s*&#39;,=C2=
=A0 # any print/printf redirect (with/without quotes)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;(?&lt;![|&amp;])\|(?![|&amp;])\s*&#39;, =
# pipe not preceded/followed by another | or &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;getline&#39;,=C2=A0 # all getline operat=
ions<br>
+=C2=A0 =C2=A0 ]<span style=3D"background-color:transparent">=C2=A0</span><=
/blockquote><div>=C2=A0</div><div><span id=3D"m_-4015722872033445661gmail-d=
ocs-internal-guid-273cda43-7fff-c246-8360-3ba462cf1c8c"><p style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt">I looked into the regex parsing=
 in the tool_awk function, to which I noticed that the dangerous patterns c=
ould be bypassed if the AI passes forbidden features part by part, for exam=
ple if &quot;sys&quot; and &quot;tem&quot; are passed individually, it pass=
es the regex check, but when the command runs it concatenates the 2 strings=
 resulting in &quot;system&quot; which is forbidden. For example:<br><br>pa=
rt1 =3D &quot;sys&quot;</p><p style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt">part2 =3D &quot;tem&quot;</p><p style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt">cmd =3D part1 part2</p><p style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt">@cmd(&quot;rm -rf /&quot;)<br><b=
r></p><p style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt">If you=
 think this would be an issue, I=C2=A0would recommend=C2=A0looking into=C2=
=A0awk&#39;s built in &#39;--sandbox&#39; argument, which inherently disabl=
es commands such as system(), getline, pipes, and file redirects.</p></span=
></div><div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 for pattern in dangerous_patterns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.search(pattern, program):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SecurityError(f&quot;AWK p=
rogram contains forbidden pattern: {pattern}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if not path.exists():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;File not found: {path}&=
quot;)<br>
+<br>
+=C2=A0 =C2=A0 cmd =3D [&quot;awk&quot;, program, str(path)]<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dgit_root,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3D30,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result.stdout<br>
+=C2=A0 =C2=A0 except subprocess.TimeoutExpired:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;awk timed out after 30 s=
econds&quot;)<br>
+=C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;awk failed: {e.stderr}&=
quot;)<br>
+<br>
+<br>
+def tool_sed(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Execute sed for text processing (read-only=
).<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - program: sed program (required=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: File path (required)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If sed fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails or program =
attempts writes<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if &quot;program&quot; not in args or &quot;path&quot; not i=
n args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;program and path paramet=
ers are required&quot;)<br>
+<br>
+=C2=A0 =C2=A0 program =3D args[&quot;program&quot;]<br>
+=C2=A0 =C2=A0 path =3D validate_path(args[&quot;path&quot;], git_root)<br>
+<br>
+=C2=A0 =C2=A0 # Security: Force read-only mode, disallow write/execute com=
mands<br>
+=C2=A0 =C2=A0 # Block w (write), W (Write), e (execute), r/R (read from fi=
le), Q (quit with code)<br>
+=C2=A0 =C2=A0 dangerous_patterns =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;[wWeRQ]\s&#39;,=C2=A0 # write, Write, ex=
ecute, Read, Quit<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;\d+[wWeRQ]$&#39;,=C2=A0 # write/execute/=
read/quit with address<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;[rR][/\s]&#39;,=C2=A0 # read from file (=
with or without whitespace)<br>
+=C2=A0 =C2=A0 ]</blockquote><div>=C2=A0</div><div><span style=3D"backgroun=
d-color:transparent">When checking for dangerous commands using regex here,=
 I was wondering if this would affect regular commands that match the patte=
rns? Please correct me if I&#39;m wrong, but I wanted to make sure that the=
 specified regex patterns wouldn&#39;t block commands that would be useful.=
=C2=A0</span>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 =C2=A0 for pattern in dangerous_patterns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.search(pattern, program):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SecurityError(f&quot;sed p=
rogram contains forbidden pattern: {pattern}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if not path.exists():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;File not found: {path}&=
quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Always use -n (suppress automatic printing) to prevent sid=
e effects<br>
+=C2=A0 =C2=A0 cmd =3D [&quot;sed&quot;, &quot;-n&quot;, program, str(path)=
]<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dgit_root,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture_output=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3D30,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result.stdout<br>
+=C2=A0 =C2=A0 except subprocess.TimeoutExpired:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;sed timed out after 30 s=
econds&quot;)<br>
+=C2=A0 =C2=A0 except subprocess.CalledProcessError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;sed failed: {e.stderr}&=
quot;)<br>
+<br>
+<br>
+def tool_file_read(args: dict[str, Any], git_root: Path) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Read contents of a file.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args: Dictionary with keys:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - path: File path (required)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - max_size: Maximum file size in=
 bytes (default: 1MB)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - encoding: Text encoding (defau=
lt: utf-8)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 File contents as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If file read fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If validation fails<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if &quot;path&quot; not in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(&quot;path parameter is requir=
ed&quot;)<br>
+<br>
+=C2=A0 =C2=A0 path =3D validate_path(args[&quot;path&quot;], git_root)<br>
+=C2=A0 =C2=A0 max_size =3D args.get(&quot;max_size&quot;, 1024 * 1024)=C2=
=A0 # 1MB default<br>
+=C2=A0 =C2=A0 encoding =3D args.get(&quot;encoding&quot;, &quot;utf-8&quot=
;)<br>
+<br>
+=C2=A0 =C2=A0 if not path.exists():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;File not found: {path}&=
quot;)<br>
+<br>
+=C2=A0 =C2=A0 if not path.is_file():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;Not a file: {path}&quot=
;)<br>
+<br>
+=C2=A0 =C2=A0 # Check file size<br>
+=C2=A0 =C2=A0 file_size =3D path.stat().st_size<br>
+=C2=A0 =C2=A0 if file_size &gt; max_size:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;File too large: {file_siz=
e} bytes (max: {max_size})&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use errors=3D&#39;replace&#39; to handle non=
-UTF8 bytes gracefully<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return path.read_text(encoding=3Dencoding, err=
ors=3D&#39;replace&#39;)<br>
+=C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;Failed to read file: {e=
}&quot;) from e<br>
+<br>
+<br>
+# Tool definitions for Anthropic API<br>
+TOOL_DEFINITIONS =3D [<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;git_log&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;View git commit=
 history with optional filters. Use this to understand recent changes, find=
 related commits, or trace the history of specific files.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max_count&qu=
ot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;integer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Maximum number of commits to show (1-100, defaul=
t: 20)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;minimum&quot;: 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;maximum&quot;: 100,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;since&quot;:=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Show commits more recent than date (e.g., &#39;2=
 weeks ago&#39;, &#39;2024-01-01&#39;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;until&quot;:=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Show commits older than date&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Only show commits affecting this file path&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;grep&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Only show commits with messages matching this pa=
ttern&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;author&quot;=
: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Only show commits by this author&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;oneline&quot=
;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;boolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Use compact one-line format (default: false)&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;git_show&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;Show the conten=
ts of a git commit or a specific file at a given commit. Use this to examin=
e what changed in a specific commit or to view historical file contents.&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ref&quot;: {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Git reference (commit hash, branch name, tag, or=
 HEAD~N)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Optional: specific file path to show at this ref=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stat&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;boolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Show only diffstat (default: false)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;required&quot;: [&quot;ref=
&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;grep&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;Search for text=
 patterns in files. Use this to find specific code patterns, function defin=
itions, or configuration values.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pattern&quot=
;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Search pattern (supports regex)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;File or directory to search (default: current di=
rectory)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;recursive&qu=
ot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;boolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Search recursively in directories (default: true=
)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ignore_case&=
quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;boolean&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Case-insensitive search (default: false)&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max_count&qu=
ot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;integer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Maximum matches per file (default: 100)&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;context&quot=
;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;integer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Lines of context around matches (default: 0)&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;required&quot;: [&quot;pat=
tern&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;awk&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;Process text fi=
les using AWK (read-only). Use this to extract columns, filter lines, or pe=
rform text transformations. Write/execute operations are blocked.&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;program&quot=
;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;AWK program to execute&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;File to process&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;required&quot;: [&quot;pro=
gram&quot;, &quot;path&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;sed&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;Process text fi=
les using sed (read-only). Use this to extract or transform text. Write/exe=
cute operations are blocked and -n flag is always enabled.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;program&quot=
;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;sed program to execute (use p command to print)&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;File to process&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;required&quot;: [&quot;pro=
gram&quot;, &quot;path&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;file_read&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&quot;: &quot;Read the conten=
ts of a file. Use this to examine source code, documentation, or configurat=
ion files.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;input_schema&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;object&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;properties&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Path to the file to read&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;max_size&quo=
t;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;integer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Maximum file size in bytes (default: 1048576 =3D=
 1MB)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;encoding&quo=
t;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;type&quot;: &quot;string&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;description&quot;: &quot;Text encoding (default: utf-8)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;required&quot;: [&quot;pat=
h&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+]<br>
+<br>
+<br>
+# Map tool names to handler functions<br>
+TOOL_HANDLERS =3D {<br>
+=C2=A0 =C2=A0 &quot;git_log&quot;: tool_git_log,<br>
+=C2=A0 =C2=A0 &quot;git_show&quot;: tool_git_show,<br>
+=C2=A0 =C2=A0 &quot;grep&quot;: tool_grep,<br>
+=C2=A0 =C2=A0 &quot;awk&quot;: tool_awk,<br>
+=C2=A0 =C2=A0 &quot;sed&quot;: tool_sed,<br>
+=C2=A0 =C2=A0 &quot;file_read&quot;: tool_file_read,<br>
+}<br>
+<br>
+<br>
+def execute_tool(tool_name: str, tool_args: dict[str, Any]) -&gt; str:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Execute a tool and return its output.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_name: Name of the tool to execute<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tool_args: Arguments for the tool<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Tool output as string<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ToolError: If tool execution fails<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SecurityError: If security validation fails<br=
>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if tool_name not in TOOL_HANDLERS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;Unknown tool: {tool_nam=
e}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 git_root =3D get_git_root()<br>
+=C2=A0 =C2=A0 handler =3D TOOL_HANDLERS[tool_name]<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return handler(tool_args, git_root)<br>
+=C2=A0 =C2=A0 except (ToolError, SecurityError):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
+=C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ToolError(f&quot;Tool execution failed: =
{e}&quot;) from e<br>
+<br>
+<br>
+def convert_tools_to_openai_format(anthropic_tools: list[dict[str, Any]]) =
-&gt; list[dict[str, Any]]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Convert Anthropic tool definitions to Open=
AI function calling format.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 anthropic_tools: List of tool definitions in A=
nthropic format<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 List of tool definitions in OpenAI format<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 openai_tools =3D []<br>
+=C2=A0 =C2=A0 for tool in anthropic_tools:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openai_tool =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;function=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;function&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: =
tool[&quot;name&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;description&=
quot;: tool[&quot;description&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;parameters&q=
uot;: tool[&quot;input_schema&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openai_tools.append(openai_tool)<br>
+=C2=A0 =C2=A0 return openai_tools<br>
+<br>
+<br>
+def get_tools_for_provider(provider: str) -&gt; list[dict[str, Any]]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Get tool definitions in the format require=
d by the provider.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 provider: Provider name (anthropic, openai, xa=
i, google)<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 List of tool definitions in provider-specific =
format<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if provider =3D=3D &quot;anthropic&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TOOL_DEFINITIONS<br>
+=C2=A0 =C2=A0 elif provider in (&quot;openai&quot;, &quot;xai&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return convert_tools_to_openai_format(TOOL_DEF=
INITIONS)<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Google Gemini uses a different format, not y=
et implemented<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
diff --git a/devtools/ai/review-doc.py b/devtools/ai/review-doc.py<br>
index e01be077fe..a084678ec5 100755<br>
--- a/devtools/ai/review-doc.py<br>
+++ b/devtools/ai/review-doc.py<br>
@@ -360,6 +360,8 @@ def call_api(<br>
=C2=A0 =C2=A0 =C2=A0include_diff_markers: bool =3D False,<br>
=C2=A0 =C2=A0 =C2=A0verbose: bool =3D False,<br>
=C2=A0 =C2=A0 =C2=A0timeout: int =3D 120,<br>
+=C2=A0 =C2=A0 enable_tools: bool =3D True,<br>
+=C2=A0 =C2=A0 max_tool_rounds: int =3D 10,<br>
=C2=A0) -&gt; tuple[str, TokenUsage]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Build the per-provider request body a=
nd dispatch via _common.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0if provider =3D=3D &quot;anthropic&quot;:<br>
@@ -399,6 +401,8 @@ def call_api(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request_data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout=3Dtimeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verbose=3Dverbose,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools=3Denable_tools,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_tool_rounds=3Dmax_tool_rounds,<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
<br>
@@ -665,6 +669,18 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metavar=3D&quot;SECONDS&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;API request timeout in secon=
ds (default: 120)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0)<br>
+=C2=A0 =C2=A0 parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--no-tools&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store_true&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Disable tool calling (git, grep, =
file read). Tools are enabled by default.&quot;,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--max-tool-rounds&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 type=3Dint,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metavar=3D&quot;N&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Maximum tool calling rounds (defa=
ult: 10)&quot;,<br>
+=C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Email options<br>
=C2=A0 =C2=A0 =C2=A0email_group =3D parser.add_argument_group(&quot;Email O=
ptions&quot;)<br>
@@ -811,6 +827,8 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.diff,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.verbose,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools=3Dnot args.no_tools=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_tool_rounds=3Dargs.max_tool_=
rounds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_usage.add(call_usage)<br>
<br>
diff --git a/devtools/ai/review-patch.py b/devtools/ai/review-patch.py<br>
index 5f8d9ed772..a3481290be 100755<br>
--- a/devtools/ai/review-patch.py<br>
+++ b/devtools/ai/review-patch.py<br>
@@ -589,6 +589,8 @@ def call_api(<br>
=C2=A0 =C2=A0 =C2=A0output_format: str =3D &quot;text&quot;,<br>
=C2=A0 =C2=A0 =C2=A0verbose: bool =3D False,<br>
=C2=A0 =C2=A0 =C2=A0timeout: int =3D 300,<br>
+=C2=A0 =C2=A0 enable_tools: bool =3D True,<br>
+=C2=A0 =C2=A0 max_tool_rounds: int =3D 10,<br>
=C2=A0) -&gt; tuple[str, TokenUsage]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Build the per-provider request body a=
nd dispatch via _common.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0if provider =3D=3D &quot;anthropic&quot;:<br>
@@ -625,6 +627,8 @@ def call_api(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request_data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout=3Dtimeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verbose=3Dverbose,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools=3Denable_tools,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_tool_rounds=3Dmax_tool_rounds,<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
<br>
@@ -870,6 +874,18 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metavar=3D&quot;SECONDS&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;API request timeout in secon=
ds (default: 300)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0)<br>
+=C2=A0 =C2=A0 parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--no-tools&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action=3D&quot;store_true&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Disable tool calling (git, grep, =
file read). Tools are enabled by default.&quot;,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--max-tool-rounds&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 type=3Dint,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metavar=3D&quot;N&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Maximum tool calling rounds (defa=
ult: 10)&quot;,<br>
+=C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Date and release options<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(<br>
@@ -1079,6 +1095,8 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.output_format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.verbose,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enab=
le_tools=3Dnot args.no_tools,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_=
tool_rounds=3Dargs.max_tool_rounds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_usage.a=
dd(call_usage)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all_reviews.a=
ppend((patch_label, review_text))<br>
@@ -1149,6 +1167,8 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.output_format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.verbose,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0args.timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enab=
le_tools=3Dnot args.no_tools,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_=
tool_rounds=3Dargs.max_tool_rounds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_usage.a=
dd(call_usage)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all_reviews.a=
ppend((chunk_label, review_text))<br>
@@ -1203,6 +1223,8 @@ def main() -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.output_format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.verbose,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools=3Dnot args.no_tools=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_tool_rounds=3Dargs.max_tool_=
rounds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_usage.add(call_usage)<br>
<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>
</div>

--000000000000409621065d588970--
