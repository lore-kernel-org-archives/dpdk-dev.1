Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CBDCD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AF7E4027A;
	Wed, 17 Jun 2026 00:42:27 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 050EF4026F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 00:42:25 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137ec563a95so5852531c88.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781649745;
 x=1782254545; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLDbcsXG/SbKzIJBc1D2tPBvyqJQf/FcVjINi8Pd3v4=;
 b=Vzzo89pTYb92JZNq0BySr8y3MjCLqlvixVLI+zfAzHi2s1zlGUxM+dv1SLDdvIQZsD
 wTUeP6OHm0cXO7dyo+slErxDby97VvfyNyolCj5DuUe6GHbeJ9nAd6tlS35UZVY0iC1z
 f/hzfCyVFMebMJ+L5yHZ/UaIYNpqoCxMLN5ENUC5orUQJAYI+XMJSswTqZw/qrKm7EVC
 ooe42iOB2e7qQAnf4M8JxLpzUyPmDVQu+hJjYD+EgZn0OWo/oTxKUctMQrkYRGbDtZ3d
 hBjRlgWe5AwGLbqdpQ/tO6oOBnDcaYAWfX+zGVD0vf4/zErRNmLazIpV84+u579IWW3Z
 JchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649745; x=1782254545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLDbcsXG/SbKzIJBc1D2tPBvyqJQf/FcVjINi8Pd3v4=;
 b=EWH7gta7h6W6Nn50hdoLpXQakiES7CY0t4L0lUhMWVB9LIb55S5PqtiyP/cD2d/yek
 G4L4A3YD73UWTud7OoJP/0RseTP5qO3oLWmZdqEbbkOdI/Xu3jV81Y4jJqOKgolgs2uz
 oZnneYF9+u42H6zn9aICtUv4XWEGewkgFoRhklYonQLBmqbrxF17jhvlv+6XrM60qNfy
 MMZmNNz12zYDlNn8syBN04kKxy78Ce4FWvC+z3i59ZhbPBJfh/0gGaiDBJgyM7tNSME3
 s+E3iwwce8ekwtYbodo7jevbTJaDyLORR5Y/HFTUqNrtA8+wxygdLOWJZyJ5otHsM12t
 j6WA==
X-Gm-Message-State: AOJu0YwHHEBpoEWPvBIPV1wmP35CelNpSMIL9mCGEjBVN+UB1hcRD5Fw
 PpRgipOWKm9xiRkWhwtWEiAL65Ss7qNS+RpQ6I9DHyqal9+U7UxU+8QpyNAzwXznjfk=
X-Gm-Gg: AfdE7cnc7XzySctGakr9/nEi75noVcR2tZpu+ptPXjITx9bWXGCKc2rQGfTvg37q+ck
 01dVGDJypykTl2guQoXggqMQy4dhM8af99uUJCH90mQmUE0Kad4mdejIQuD963gB5a9nXghmm98
 Qk4YAoBjdVkn5hd6XhWgrQIH4YalEJlYnUG1ezZAUhKVMZH0Mbe2harexmz8Tat3zylLAuJalcG
 Eu86Xew3SGV5hg8J4JUY3SSTTEaYc5ksTUI+lMUs1QWUeSy4GFugeBQw4D/rE4Ro+KgGkX660I4
 GMRpGa+nmrVmy5hvDu4+982tTW8j8WK4At69TqeNmbatr2iDQg1hv/LGBaE1zsZfCKkwBjwxYtV
 eJuropy1bfTU8UJRaJ6NQW+VAo7pnuJ5FRBugnxDbTiOPOUbsdpr5Ygg5TvOjjBEHZouJFOBqDk
 rA59Musu1FEPAPVuby2sldtqQOq8SAQ3pEGdeSV+F6d+kF0UYPgHPTSbFwuf7qHS+Q
X-Received: by 2002:a05:7301:2f8b:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-30bca0e256amr682540eec.25.1781649744671; 
 Tue, 16 Jun 2026 15:42:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd23401ecsm170167eec.25.2026.06.16.15.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 15:42:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:42:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: add tool calling support to review-patch.py
Message-ID: <20260616154221.42d0c5d5@phoenix.local>
In-Reply-To: <20260609182652.1053422-1-aconole@redhat.com>
References: <20260609182652.1053422-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue,  9 Jun 2026 14:26:47 -0400
Aaron Conole <aconole@redhat.com> wrote:

> Add an iterative tool-use loop to review-patch.py for the Anthropic
> and OpenAI providers. The reviewer can now look up additional context
> from the DPDK source tree when the patch alone is insufficient,
> rather than having to guess at surrounding code, API contracts, or
> function signatures.
> 
> Tool calling is enabled by default with a limit of 10 rounds. Pass
> '--tool-rounds 0' to disable it and restore the previous single-shot
> behavior.  The round limit prevents runaway cost on large patches
> that when reached will force the model to deliver a final judgement.
> 
> Initial tool set:
>   - grep           Searches for regex across the file system with
>                    optional path restrictions and case-insensitive
>                    matches.
>   - file_read      Line range read of a specific path.
> 
> Both tools are limited to the repository root to prevent path
> traversal.  Path outputs are relative to the repo root.
> 
> The system prompt is extended when tool calling is active to
> encourage the model to use tools only when genuinely needed,
> keeping unnecessary round trips and token costs under control
> and to a minimum.
> 
> Internally, _common.py gains send_request_raw() (returning the
> raw response dict) so the tool-calling loops can inspect
> stop_reason / finish_reason before extracting text.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---

Well AI saw the security bypass here...

Error
=====

devtools/ai/review-patch.py: path containment check is bypassable
(_tool_grep and _tool_file_read)

	repo_resolved = Path(repo_root).resolve()
	search_path = (repo_resolved / rel_path).resolve()
	if not str(search_path).startswith(str(repo_resolved)):
		return "Error: path is outside the repository"

str.startswith() on the resolved path string is a prefix match, not a
path-component match. If repo_root resolves to /home/me/dpdk, then
/home/me/dpdk-private/secrets passes the check, since the string starts
with "/home/me/dpdk". The commit message states both tools are "limited
to the repository root to prevent path traversal" -- that property does
not hold for sibling directories sharing the name prefix. Same bug in
both tool helpers.

	# is_relative_to (3.9+), raises nothing, no string games
	if not search_path.is_relative_to(repo_resolved):
		return "Error: path is outside the repository"

(Absolute rel_path and ../ escapes are already caught by resolve() +
this fix; only the prefix case is currently open.)


Warning
=======

devtools/ai/_common.py: unrelated reformatting mixed into a feature
patch. The docstring re-wrapping in print_token_summary(),
_extract_text(), _print_verbose_usage(), and the classify_review()
regex reflow in review-patch.py are cosmetic churn unrelated to tool
calling. Drop them or split into a separate cleanup; they inflate the
diff and obscure the actual change.

devtools/ai/review-patch.py: grep --include list excludes the files the
tool prompt points the model at. _tool_grep restricts to
*.[ch]/*.py/*.rst/*.ini, but TOOL_PROMPT_EXTENSION explicitly directs
the model to check ".ci/" scripts, meson.build, and MAINTAINERS. Those
are extensionless or shell, so grep silently returns "No matches found"
rather than surfacing the omission. Either widen the include set or
note the restriction in the tool description so the model doesn't draw
false conclusions from empty results.


Info
====

xai is OpenAI wire-compatible and already shares build_openai_request()
elsewhere, but tool calling is gated to provider == "openai" in
call_api() and the verbose banner. xai (and any future
OpenAI-compatible provider) falls back to single-shot with no notice.
Reusing call_api_with_tools_openai() for xai looks free.

send_request_raw() bypasses _extract_text(), which is where the
"error" in result check lived. The tool loops read stop_reason /
choices directly, so a provider error returned with HTTP 200 yields an
empty string and a misleading "clean" review instead of a hard failure.
Worth a guard on api_result.get("error") at the top of each loop body.

Default-on at 10 rounds is a behavior and cost change for every existing
caller, and grants repo-wide read to the model by default. Reasonable
for an RFC to propose, but worth calling out explicitly for the list --
some CI users may want opt-in rather than opt-out.
