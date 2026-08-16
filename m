Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBAC5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 22:32:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEBB340294;
	Mon, 17 Aug 2026 00:32:46 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7DDFC4027A
 for <dev@dpdk.org>; Mon, 17 Aug 2026 00:32:45 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d01663d816so23441665ad.1
 for <dev@dpdk.org>; Sun, 16 Aug 2026 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786919564;
 x=1787524364; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JzUh/o6STfP8YsG9Encha9wQjbsFyOxG1lWwjyUfGZg=;
 b=Af2t52NKlUpXzP/QSinrc+ZwOsqaVe7M5uAD4q86K5KCg3jpeGokfMJQx67Q1jQXkO
 ilEI7uSL+A6sWsaA8f+n9w2e2T+S48AXxK9THZY/V3P0Pp3Iu59b2uOgNreAAAJ2k6rx
 d67n7JkocJT4P0/fKWiE1AMP6vllrmf+rSzUXi0fPFDTnI+3rzc8KwIK6HhCUcdKiin6
 S15X1UNlHWQ68MJwyoeFsHEdLOVKOvqG+AYzhuEohvzSb5l9mQE+tlKpTkp/kzxEproI
 253jIMyDqBKt3EVtEwoqFBrt3Cb/hakuUEu1rCuEibX+fuXJ+aNBk+2Qc74M0WP6AEv+
 WINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786919564; x=1787524364;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JzUh/o6STfP8YsG9Encha9wQjbsFyOxG1lWwjyUfGZg=;
 b=olOSERj7anbwiyPXwIRLA4ltvTOqNSvhBgIwDbN+jwsBWRaGY6WK6o4ozZ25yUeb9S
 x4zVvDOU1BtOaNSG3JOjN6qz/kQ7imYqO5nlLr5I3xObU7K20zlxjQmyW9uPec0yZkvP
 kAO3EIb7Grv03QjsrffXWJjUIKnG8xZE9s7Bguem7qhhW3xsYJ0128e2cKrgg+acR5z1
 WmRkK6AtJ3Qjz7Oj+5WLkFrhRS9sltZ1vqHeZWkAty+/8fuxGPFmWXUdelaw+RRc3Jpa
 YiwhVyt8pjUmpNXzDjCa6k4bisnmYyPb4SX/Ws1oRiD69te0F/OJ7OYQN9+Jsxb0jDAt
 kdBw==
X-Gm-Message-State: AOJu0YzUGosgEUZaAKE7NAlReljMQ4FKfKXO/9jpwhRmJtrrOsSLSR1T
 UqzF+TaiDJwecjUoCvxR3sDNhFnRfwXrs6x9gCCxFjVoIAeDba+v8SSxieEz/7mYNvQ=
X-Gm-Gg: AR+sD13gLDkFbr7rQLUCShtT8AkTawT+Gu2dwiPtSkuWB4HT0E8X6E/GFyggQmBEkHe
 eVFPmq3Zke1+aokizpn0tFbNuim8vOO81EElgLm31BSEofnaySJHbcUDgUJWaiJNpTXb90xupc/
 dsN2hQYIEkFe/V0M9432VEKEv0IhUFqJvUDRJ+b27VM9FiQvfCauZ2gIHgGl/DbY5FdSQPR/8P/
 WvqDn4X/oPiv4BXsAgM4KVmN8MM5hcG6AQT4EP1PU5cyR7DuzYnwwJJmbwXvKKf1lQ7Uhj+K/qG
 eBspTSZ7tqHVOnxT1UHyBAzLekeYi9BeQqRT68e9vukregGbZ9JYwhaAJvpNE4CGFHymt9Nlzd6
 +P07oHDmVI7sMgC6O6PVDOx4VIrPBsx3vnT/Z+N2wEXFcKAfDiR9VFuCvHTcceDvJj7ABNPSD6m
 BsyY3zYHfkkmMorlH6+3E17fB47UWO64TPDyOYHp4ejrXXkQxcL2PYTToZUYo+QXnuZXiTdC6o5
 PW0cLOajDtnJ0hUUGvGTuv/l8wQfUhtVaI=
X-Received: by 2002:a05:6a21:10e:b0:3bf:7994:ddca with SMTP id
 adf61e73a8af0-3cc71d5074cmr23501781637.29.1786919564346; 
 Sun, 16 Aug 2026 15:32:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387af4adsm32596999c88.1.2026.08.16.15.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 15:32:44 -0700 (PDT)
Date: Sun, 16 Aug 2026 15:32:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: dev@dpdk.org, Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH 1/2] lib/pipeline: bound token concatenation when
 parsing instructions
Message-ID: <20260816153234.55ec12c2@phoenix.local>
In-Reply-To: <20260321021627.96424-1-pengpeng@iscas.ac.cn>
References: <20260321021627.96424-1-pengpeng@iscas.ac.cn>
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

On Sat, 21 Mar 2026 10:16:27 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> action_block_parse() and apply_block_parse() build instruction strings by concatenating untrusted tokens into a fixed-size stack buffer. Replace the open-coded strcat() loop with a helper that tracks the remaining capacity and fails when the assembled instruction would exceed RTE_SWX_INSTRUCTION_SIZE.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

This patch has serious problems. Finally ran it through AI.


General: these two patches touch unrelated subsystems (lib/pipeline
and net/cpfl), have different maintainers, and are not threaded
(each has its own Message-ID with no In-Reply-To).  They should be
sent as two independent submissions rather than a 1/2, 2/2 series.

Neither patch carries a Fixes: tag or Cc: stable@dpdk.org.  Both
claim to fix buffer overflows in code that shipped years ago, so
both need them.


Patch 1/2: lib/pipeline: bound token concatenation

Error: resource leak in rte_swx_pipeline_table_config()

  CHECK_STRLCPY(t->args, args, EINVAL);

  CHECK() expands to a bare "return -(err_code)".  This call site
  sits after six successful calloc() calls (t, t->fields,
  t->actions, t->default_action_data,
  t->action_is_for_table_entries, t->action_is_for_default_entry).
  Every other failure past "t = calloc(...)" in that function uses
  "goto error", which frees all of them.  A long args string now
  returns -EINVAL and leaks all six allocations.

  This is the concrete hazard in wrapping strlcpy() in a macro that
  hides control flow: the macro is correct in isolation and wrong
  at the only site where it matters.

  The rest of the function validates its string inputs up front
  with CHECK_NAME(), before any allocation.  Doing the same here
  fixes the overflow with no new macro and no leak:

	if (args && args[0])
		CHECK_NAME(args, EINVAL);

  placed next to the existing CHECK_NAME(name, EINVAL), leaving the
  strcpy() in the node-initialization block alone.

Error: err_line / err_msg left unset on the new failure path

  In both action_block_parse() and apply_block_parse():

	if (buffer_append_tokens(buffer, sizeof(buffer), tokens, n_tokens))
		return -ENAMETOOLONG;

  Every other error return in these functions sets *err_line and
  *err_msg before returning.  pipeline_spec_parse() does not
  initialize them either, and callers pass uninitialized locals.
  See examples/pipeline/cli.c:586, which declares

	uint32_t err_line;
	const char *err_msg;

  and on failure does

	snprintf(out, out_size, "Error %d at line %u: %s\n.",
		 status, err_line, err_msg);

  So this path prints an uninitialized pointer through %s.  Set
  both fields, and propagate the helper's return value instead of
  re-hardcoding -ENAMETOOLONG.

Warning: 11 of the 12 strcpy() conversions are dead code

  instr_translate() already validates every token as it is
  tokenized:

	CHECK(n_tokens < RTE_SWX_INSTRUCTION_TOKENS_MAX, EINVAL);
	CHECK_NAME(token, EINVAL);

  CHECK_NAME enforces strnlen(token, RTE_SWX_NAME_SIZE) <
  RTE_SWX_NAME_SIZE, and both instruction_data.label and
  instruction_data.jmp_label are char[RTE_SWX_NAME_SIZE].  No token
  reaching instr_jmp*_translate() or the label handling in
  instr_translate() can overflow, so none of those eleven sites can
  overflow today.  That check was added in commit 0dde44843b
  ("pipeline: fix string copy into fixed size buffer") for exactly
  this class of Coverity report.

  t->args is the one genuinely unchecked destination: it comes
  straight from the public rte_swx_pipeline_table_config() argument
  and from the .spec file table args, with no length validation
  anywhere.  Fixing that one site is worthwhile; the other eleven
  add code without removing a bug.

Warning: commit message describes only half the patch

  The message covers action_block_parse() and apply_block_parse()
  in rte_swx_pipeline_spec.c.  It says nothing about the twelve
  changes to rte_swx_pipeline.c or about the new CHECK_STRLCPY
  macro, which is where the reviewable behaviour change is.

Warning: missing Fixes: and Cc: stable@dpdk.org

  For the strcat() loops:
  Fixes: 3ca60ceed79a ("pipeline: add SWX pipeline specification file")

  For the t->args copy:
  Fixes: e9d870dd93e1 ("pipeline: add SWX pipeline tables")

Info: CHECK_STRLCPY() is fragile if it survives

  sizeof(dst) is silently the pointer size if dst is ever a
  pointer or an array parameter.  All twelve current uses are true
  arrays, so it works, but the file's existing idiom (CHECK_NAME,
  CHECK_INSTRUCTION with an explicit size constant) does not have
  that trap.  If the macro stays, take the size as an explicit
  argument.

Info: the strcat() fix itself is correct

  buffer_append_tokens() is sound: the loop invariant keeps len <
  buffer_size, and the snprintf() return check catches truncation.
  The joined line really can exceed RTE_SWX_INSTRUCTION_SIZE (256),
  since the spec tokenizer accepts lines up to MAX_LINE_LENGTH
  (2048) and up to MAX_TOKENS (256) tokens, so this part of the
  patch fixes a real stack overflow.

