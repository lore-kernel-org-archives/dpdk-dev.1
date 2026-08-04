Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56BBC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 16:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07CE74068A;
	Tue,  4 Aug 2026 18:18:30 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id BD20E40685
 for <dev@dpdk.org>; Tue,  4 Aug 2026 18:18:28 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so5372042b3a.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785860308;
 x=1786465108; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=if7S+FNIKy41v5Oj8klsAh91ip4YDbacufOxgyaD5Ng=;
 b=AqGLXvmDjrMX0ZEdN3XlK6Y0FU6xYqdk5jD4haBKB8yTQ9EFFtKMrmgiAZSE0hj/1y
 gpJ8tGziAWh5FkVbp2VGeYNkdhedRaZ20OHLpKyZ44NPzSKo4VmGDiGAFybQ5cGWTj2Z
 4qs7hK+gmtUfArOtD35gPxMBgURvTIdc8kZeav8TUI/9jtJqojSN87wVTcPDVFbNEpqQ
 HeV3MnbSZoXKSKEE6u8vLd7bzKBmKwKi9IlfTS/+ilYgEPISAhBUHv47oScEM38tCLg9
 bNnGKM9l+0KHGbLkQHTI37l+Ue7WjcZ8YUW/SIcCz9jbyZOg82iOv10JzrswXxBorMZm
 LOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785860308; x=1786465108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=if7S+FNIKy41v5Oj8klsAh91ip4YDbacufOxgyaD5Ng=;
 b=SSzGY5MAVQMrGM0WiAv0686TpMpnGvPUYh/KNan6TQf/1p+sSdyimMjY+q3PIpDx80
 o9g+wVTrVkk0Kxh7S/bI/mCVB1eLUSIV1Lp86tySHj5l+wNqTzocRBk9edI1eDSUgR5M
 quRXuDFlKd1jvAnn+TfMQHVNga9fvhTfWEvSYlIR3tsP3i6rM8j7VlocKqRXr7ndF1wh
 CX5jk0UMGUd3tL48EcjcMQXgN2iiv8Glx48FLJOfQR9LPj1NFVU9vnvc2TIJYSlj7ErB
 z/PSfp/IDljs8EBO0BmF5/irg+UaIp7EiOepZi50s0kXst1EiNmCXsSevJTY9qp59Jqg
 M3+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RowyAV4E8ZzY74XviNCyXh0SFXPmeW4UAT0bbclR9G2wdh3SZ35tUQNTmO582DksltErAw=@dpdk.org
X-Gm-Message-State: AOJu0YyH/GyUhmkIgz6P4G/h1mUCFnOj43/sTjHdEeGv94ZFvGOYPhiQ
 Ucs8JtZNfiiSyytawOW1C6u0Zqr7RWZBvLyocSvV3wx0pfgqcNxKy8w+B7xZ7QM+FOE=
X-Gm-Gg: AR+sD13zdsR6B0xiL5KZ4fNk0VKGt6R+oecGHwbFcjnZgzlJnvRbIYKsQZKd+t1octQ
 yWRSsV7Quhsv3763tEt8oVP/sCb1rFbSKQVZsloiF7EsDNHU86ktygi08OKV28fBmSfpmJXGII2
 5Zq+HPIhvrOcQPzaoG/mikqtGrV42nWODaykyz2Bw+mB49SwLbex5ASobOPLA8LIxHsIKP0yl0A
 7CRLIlhANLZMEmEAMFlrtrqvJYqlIqGD+8UE3ZhXnyYOd6komEfCGxTfzWP5f7N3anGSP6mXeq6
 ougY/6l337D+PitwJGyrufOn2RHX6MIqa4b08gC7zF3joPEIvrUXUPsy4BGOdpw3FeH5c4nJqfx
 aUwWJTtrFifZbfyZKLQU1SXYsd3WTJrsoTq+9b5dBIseIUtKVyU1zAS2p/585c2IJuZX0HCKUVb
 kYz2u367PkJ82qIPuExwz5JX6ot9Jy8XrrMPBe6uBnpsgAP3yuPrvAglP1P897+5EwVrqkVi6nk
 T/BT1n7CKBNVL3nR0DQ7ZPpAmL2fAmR2aZ5hlDawA==
X-Received: by 2002:a05:6a21:6009:b0:3bf:b6e3:fbe1 with SMTP id
 adf61e73a8af0-3cb86482fd4mr7213637.55.1785860307546; 
 Tue, 04 Aug 2026 09:18:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca508a48sm4443618c88.1.2026.08.04.09.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:18:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:18:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: datshan@qq.com
Cc: thomas@monjalon.net, aconole@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v3] devtools: support local opencode agent for patch review
Message-ID: <20260804091820.2e802ed3@phoenix.local>
In-Reply-To: <tencent_CFE5ECAF36405DFD2FB29DB7319B04E72C08@qq.com>
References: <20260703091902.525837-1-datshan@qq.com>
 <tencent_CFE5ECAF36405DFD2FB29DB7319B04E72C08@qq.com>
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

On Sat, 25 Jul 2026 16:43:45 +0800
datshan@qq.com wrote:

> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> Currently review-patch.py only supports cloud AI providers
> (Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.
> 
> Add a --via option that invokes the locally installed opencode CLI as
> the review runner instead of making HTTP calls. opencode reads
> AGENTS.md from the DPDK project directory automatically, needing no
> configuration beyond opencode on PATH.
> 
> The --via and -p/--provider options are independent -- via routes to
> the local agent mode while -p continues to use the cloud API path.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> ---

Good idea, AI review with Claude Opus found:


Errors:

1. opencode "error" events are silently dropped.
   The parse loop handles only "text" and "step_finish". The event
   stream also emits {"type":"error","error":{"name":...,
   "data":{"message":...}}} for rate limits and provider failures.
   If a session errors after emitting some text, the partial review
   is returned as if complete, and classify_review() will exit 0.
   A review tool reporting "clean" on an aborted run is the worst
   failure mode here. Handle it:

           elif event_type == "error":
                   err = event.get("error", {})
                   error(f"opencode: {err.get('name', '')}: "
                         f"{err.get('data', {}).get('message', '')}")

2. All text parts are concatenated, including intermediate narration.
   Unlike a single-shot API call, an agent interleaves text with tool
   calls, so text_parts collects the model's running commentary
   ("Let me read AGENTS.md first...") along with the actual review.
   That commentary ends up in the output file, in the --send-email
   body, and is scanned by classify_review() -- a narration line
   starting with "Error" flips the exit code to 3.
   Keep only the final assistant message: track part.messageID and
   emit the parts whose messageID matches the step_finish that has
   reason == "stop".

Warnings:

3. agents_path is passed to --file unresolved.
   patch_temp is absolute (tempfile), but str(agents_path) is
   whatever the user gave and defaults to the relative "AGENTS.md",
   while opencode is launched with --dir pointing at the repo root
   rather than the caller's cwd. Use str(agents_path.resolve()).
   Related: the commit message says opencode picks up AGENTS.md from
   the project directory automatically. If so, --file agents_path is
   redundant in the default case, and with -a it adds a second file
   rather than replacing the project one -- so -a does not mean what
   it means on the cloud path. Pick one behaviour and state it.

4. Verbose logs are captured and discarded.
   -v appends --print-logs, which writes to stderr, but
   capture_output=True swallows stderr and it is only surfaced
   (truncated to 500 chars) on non-zero exit. So --via -v gives the
   user none of the logs it just asked for. Either drop
   --print-logs or pass stderr=None when verbose.

5. Failure diagnostics are thrown away.
   JSONDecodeError does "continue", so if stdout is ever not JSONL
   (schema change, older opencode, a wrapper printing a banner)
   every line is skipped and the user gets only "No review text
   received from opencode". Include the first few hundred chars of
   stdout in that error message.

6. Options silently ignored in --via mode.
   -p/--provider, --auth, -t/--tokens and --max-tokens have no
   effect; only --large-file warns. Since -p has a default you
   cannot tell "unset" from "explicitly set" -- give it
   default=None and resolve to anthropic later, then parser.error()
   when --via is combined with an explicit -p or --auth.
   The commit message's claim that "--via and -p/--provider are
   independent -- ... -p continues to use the cloud API path" is not
   what the code does: --via wins and -p is dropped.

7. Documentation not updated in the same patch.
   doc/guides/contributing/patches.rst, "AI-Assisted Patch Review",
   states the script supports four providers and that an API key must
   be set. --via opencode is user-visible and removes that
   requirement. Code and docs go in the same commit.

8. The agent runs with the default toolset in the source tree.
   opencode run --dir <dpdk root> with no --agent or permission
   restriction gives the reviewing agent write/edit/bash on the
   working tree. A review should not be able to modify the tree it
   is reviewing. Restrict it to a read/grep/glob agent, or document
   the exposure.

9. black reformats the new code in four places: the cmd list literal,
   the argument packing in _run_review(), and lines 1211 and 1269
   (93 chars each). Line 1287 is pre-existing but this patch
   re-indents it, so it may as well be wrapped now.

Info:

10. estimated_tokens = 1 / max_input_tokens = 0 as a sentinel so that
    "if estimated_tokens > 0" means "not already reviewed" is
    fragile. An explicit already_reviewed flag reads better.

11. usage.api_calls = 1 if steps > 0 else 0 -- an agent run is
    "steps" calls, not one, and print_token_summary() suppresses the
    entire summary when api_calls == 0, so a run with text but no
    step_finish prints nothing under --show-tokens. Use
    usage.api_calls = steps.

12. Metadata is inconsistent: provider_name is "OpenCode" while the
    JSON "provider" field gets args.via, i.e. "opencode".

13. compare-patch-reviews.sh only iterates providers that have API
    keys and has no way to include the local runner. Worth a
    follow-up if comparing local against cloud is the point.
