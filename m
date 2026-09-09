Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5CC79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EBB640E2F;
	Wed,  9 Sep 2026 16:13:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEB124067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 16:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788963183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShgRDC+GfVwH0+TS75HF/S0lcbnBZSUfbFarHLrRitE=;
 b=SGE9VG6tHnZJiyTAeC1LUQXP6uQW+VMST3HF8a+ssCRovKBMuJXYlHKVukJq8ytFcyKZH8
 9aoL2Dk0P1jWA6yvaJWv2r1dFjPP/fuPKwREAP720hB+CJVfmPHgdkKjzOh1aHfcgf+rmB
 TmALVGwVELU+oyD3chT44kn/iIJzhTI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-M9FQsmkOMEmF7K0wHuoYWw-1; Wed, 09 Sep 2026 10:12:42 -0400
X-MC-Unique: M9FQsmkOMEmF7K0wHuoYWw-1
X-Mimecast-MFC-AGG-ID: M9FQsmkOMEmF7K0wHuoYWw_1788963151
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e9f6a49e69so9146241a34.0
 for <dev@dpdk.org>; Wed, 09 Sep 2026 07:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788963148; x=1789567948;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ShgRDC+GfVwH0+TS75HF/S0lcbnBZSUfbFarHLrRitE=;
 b=QK5YhXNhHQfCdarFM9/Lga0v9RHnaFg0+AozbQWWnnTucl03bsdnO648aNvUJaKxn6
 OeDEqAO1ae+PZEagutKrN4kl2ILLsO1aIQ8CElEsn9GxmtvosSbGdTfsg7WuAKF7nzhA
 /ckddxRycmoUFU4AHB6MeM9HMP+BxPf7dGxnFluIIfj0N0ATGQSqug5B4DGe42oqFb66
 JlgA0F1wdzAlFHZYpMcZiOqIFaOzwoqMrC0U9DQ6uj7oGLcnznUXM2/T4kHxh74isDhQ
 meCzjHdhI4EacP2C69Xl1PJyIxTV3C20gPztqm2UUhCPqIpOEl10vZH5zwTsl6EcR/Dy
 6MMg==
X-Gm-Message-State: AFuF++mZFMNV9pSItLiUqULdArTRqkaJi44PF0AU1/uCKnv7ksbMgezf
 E0frmXVnAPp4JGWlpeTSNP2weWk22ZsNplUr4ePZ0TAFiaTm/bza6xO9J0VLHD/K7fvy3gFUf9f
 ErMbNfv9C+bnMpk/LBYvR9hg/Xm+U47pH46zk/uNfXwcBS5MqjK8/
X-Gm-Gg: AYBFou2Z41+BsVTA2UlIKpCW/ZhVVnYkvlusDKnL3X6ELL0OF5DIvf9qCTFt6c7H2+4
 L+eEkAGPOLxA3oBAW01j5ttKMh0dn22LLNja4MMxWpLr9PWP+feiZvw+NacxRdWclMRnxl5I9vQ
 MMV6OQ1iwq3fuQpPbxLvG7Gu0BEpZGH/duxzi3cn13MF5HQZBUaIQ4ZZfDqkI7hr9xmVKOI7BII
 J6OF1VA/4AjjL+OltqduXbZset7zTbare4QgcEEJtYkyV8zA0AuInJrjY7vFBFkXcVQhgBusVoH
 wyW8K8xs1R9cz1Uik0xF5uUW2mUEBWSgb1gn8BUo6wlGUSXf19UT4vEI6umMsnAYulirmvVoGTw
 cFYlfQrWFkni5GlxyajJhOHFsZPla
X-Received: by 2002:a05:6820:1c81:b0:6be:dc4:13f0 with SMTP id
 006d021491bc7-6be0dc419b3mr2457810eaf.49.1788963148129; 
 Wed, 09 Sep 2026 07:12:28 -0700 (PDT)
X-Received: by 2002:a05:6820:1c81:b0:6be:dc4:13f0 with SMTP id
 006d021491bc7-6be0dc419b3mr2457744eaf.49.1788963147578; 
 Wed, 09 Sep 2026 07:12:27 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939a3b906b8sm885067085a.38.2026.09.09.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:12:26 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,  David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: add tool calling support to review-patch.py
In-Reply-To: <20260616154221.42d0c5d5@phoenix.local> (Stephen Hemminger's
 message of "Tue, 16 Jun 2026 15:42:21 -0700")
References: <20260609182652.1053422-1-aconole@redhat.com>
 <20260616154221.42d0c5d5@phoenix.local>
Date: Wed, 09 Sep 2026 10:12:25 -0400
Message-ID: <f7t7bkuo6nq.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5mhc2Axb_9I9J21fbkgYYGOOJ1E0v0b9GzqT82kgjuo_1788963151
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> On Tue,  9 Jun 2026 14:26:47 -0400
> Aaron Conole <aconole@redhat.com> wrote:
>
>> Add an iterative tool-use loop to review-patch.py for the Anthropic
>> and OpenAI providers. The reviewer can now look up additional context
>> from the DPDK source tree when the patch alone is insufficient,
>> rather than having to guess at surrounding code, API contracts, or
>> function signatures.
>> 
>> Tool calling is enabled by default with a limit of 10 rounds. Pass
>> '--tool-rounds 0' to disable it and restore the previous single-shot
>> behavior.  The round limit prevents runaway cost on large patches
>> that when reached will force the model to deliver a final judgement.
>> 
>> Initial tool set:
>>   - grep           Searches for regex across the file system with
>>                    optional path restrictions and case-insensitive
>>                    matches.
>>   - file_read      Line range read of a specific path.
>> 
>> Both tools are limited to the repository root to prevent path
>> traversal.  Path outputs are relative to the repo root.
>> 
>> The system prompt is extended when tool calling is active to
>> encourage the model to use tools only when genuinely needed,
>> keeping unnecessary round trips and token costs under control
>> and to a minimum.
>> 
>> Internally, _common.py gains send_request_raw() (returning the
>> raw response dict) so the tool-calling loops can inspect
>> stop_reason / finish_reason before extracting text.
>> 
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>
> Well AI saw the security bypass here...
>
> Error
> =====
>
> devtools/ai/review-patch.py: path containment check is bypassable
> (_tool_grep and _tool_file_read)
>
> 	repo_resolved = Path(repo_root).resolve()
> 	search_path = (repo_resolved / rel_path).resolve()
> 	if not str(search_path).startswith(str(repo_resolved)):
> 		return "Error: path is outside the repository"
>
> str.startswith() on the resolved path string is a prefix match, not a
> path-component match. If repo_root resolves to /home/me/dpdk, then
> /home/me/dpdk-private/secrets passes the check, since the string starts
> with "/home/me/dpdk". The commit message states both tools are "limited
> to the repository root to prevent path traversal" -- that property does
> not hold for sibling directories sharing the name prefix. Same bug in
> both tool helpers.
>
> 	# is_relative_to (3.9+), raises nothing, no string games
> 	if not search_path.is_relative_to(repo_resolved):
> 		return "Error: path is outside the repository"
>
> (Absolute rel_path and ../ escapes are already caught by resolve() +
> this fix; only the prefix case is currently open.)
>
>
> Warning
> =======
>
> devtools/ai/_common.py: unrelated reformatting mixed into a feature
> patch. The docstring re-wrapping in print_token_summary(),
> _extract_text(), _print_verbose_usage(), and the classify_review()
> regex reflow in review-patch.py are cosmetic churn unrelated to tool
> calling. Drop them or split into a separate cleanup; they inflate the
> diff and obscure the actual change.
>
> devtools/ai/review-patch.py: grep --include list excludes the files the
> tool prompt points the model at. _tool_grep restricts to
> *.[ch]/*.py/*.rst/*.ini, but TOOL_PROMPT_EXTENSION explicitly directs
> the model to check ".ci/" scripts, meson.build, and MAINTAINERS. Those
> are extensionless or shell, so grep silently returns "No matches found"
> rather than surfacing the omission. Either widen the include set or
> note the restriction in the tool description so the model doesn't draw
> false conclusions from empty results.
>
>
> Info
> ====
>
> xai is OpenAI wire-compatible and already shares build_openai_request()
> elsewhere, but tool calling is gated to provider == "openai" in
> call_api() and the verbose banner. xai (and any future
> OpenAI-compatible provider) falls back to single-shot with no notice.
> Reusing call_api_with_tools_openai() for xai looks free.
>
> send_request_raw() bypasses _extract_text(), which is where the
> "error" in result check lived. The tool loops read stop_reason /
> choices directly, so a provider error returned with HTTP 200 yields an
> empty string and a misleading "clean" review instead of a hard failure.
> Worth a guard on api_result.get("error") at the top of each loop body.
>
> Default-on at 10 rounds is a behavior and cost change for every existing
> caller, and grants repo-wide read to the model by default. Reasonable
> for an RFC to propose, but worth calling out explicitly for the list --
> some CI users may want opt-in rather than opt-out.

I think I've addressed many of the above issues.  Posting the 'PATCH'
version.

