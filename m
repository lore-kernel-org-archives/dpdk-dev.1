Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07CBFCB621
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C45124113C;
	Fri,  6 Mar 2026 17:43:05 +0100 (CET)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48]) by mails.dpdk.org (Postfix) with ESMTP id B6630402E3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:43:03 +0100 (CET)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-662f91bba0fso7718254eaf.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772815383;
 x=1773420183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+CV36tho0SS9btMpvxQ3a2p1Wvu+jugLebLMrfgems=;
 b=VWqNEPv2o+R07nbCI19ps5EDoWAIcHWYPSbuSlh2Lwg+ytiNR7+CkrudWC6SZaU2aK
 IbhCcFF5+JN7+O9y1nVc/KwVOwxCJ0tqpx2cFVOEaNHMjxxw90f2v1gyU1ylW48KvpAb
 7TTUVit7cS8yPclJ7KJm52ueQvL1gny5js4tLgSfIBTdn0xmKhtB6V0kae2qgzBjX2/3
 GkWjQG0T6H1PgUHfoclGLBpknTslEYA076zoONhnWPbhICNIBsAvLoZrC92mXMihOhcm
 ZcQ9eZf0ZBuDStj9YmDPhZsKwbdUMVdCPXS1+endDch+RfHnr5uyEBZi+r1n2lteAJxk
 /7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815383; x=1773420183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+CV36tho0SS9btMpvxQ3a2p1Wvu+jugLebLMrfgems=;
 b=XgKaBxhymrLEFEZtfcRbnPcFlpOVb89mC5WBA6o6o0YrND+HTyPnw/0pBjlEnJc4sg
 lTCYVIb0muVB9OFI/K4VCTLmSxuQ6E6gQLeUqNGe44h/etXQ5AUcY5hG3cjAs/nLn2D0
 jefMjH/WzeNA1oUE1nNPGNJEuesti4kjQNMGOIFDQyov0PKUo1QmFKMYqQ+Dhp/X973H
 PNKRxLCgsXnO4ctNFdcR5/Ja+H2/tWbHP20rS7BK5LVMiWpZVrpUJrttEPqHUPb6x1s1
 3w++5j1bqGpeBdsqUC0EfbDS619wOLroDDdj13rVMjcADyxq5XtSFFU6Lwb5wBRYn3lQ
 UOoQ==
X-Gm-Message-State: AOJu0Yz4MeCukCAx2lX9RNO8eQxUW78Dz7RdiGMZdJvzS3RnH6TL1Mgw
 wF4CJrPb59WX5bwGyADvgPygn0RMQDZnxcTUuxwpvlw/Sas3nwXhIdzfvPCL60EjenY=
X-Gm-Gg: ATEYQzyVdTGPzR1otDppWlmBRekpdSz4cWMf2I8/xJ/mzFxZ0wDgsFKmQO5YnbukWC+
 jozB3HS5aLpcEE82ZOc7iinbpTjmkvgNIrrYd9J8z0BmqOG7Bsd7iJ+AlEj7rZ9dyeSsN7tr2Kg
 70tS74lh2G/uXI26l9bNhJ45++G4VwXqFKvTKHk8h4gzPKKWYxJMv1hrujzTvu6i5xIhT7dRggw
 gqZR9C8ZS9MwgLYrJARpw8R4C3/778G0oBxhSGPfn+G5ezhDLGuRB3vYoXT/3vl4Olun9muRjYv
 vBhBEfEyu9mQKlL8agkflTSzFiyghd0ZzmeGK1Bo2V257Jjs2BDJjWGSJa3mAubEOMe6wsHmDFB
 gxLSG+CHj1MXE/Sxl+UDAoFCRxlhBB18Nvz+sU4EhEymixFNJsoJBPPTQbcY07I+gfxMCEwIV5M
 bMMpXTrM10vPV8SJfXItpp4Y4y1Qh0tidvKAtDrXVlhHchLdwgfGLW3N/1JBp5dsqd
X-Received: by 2002:a4a:e915:0:b0:67a:54b:3dcf with SMTP id
 006d021491bc7-67b9c3f3a8bmr1430295eaf.20.1772815382898; 
 Fri, 06 Mar 2026 08:43:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9d460813sm1138626eaf.7.2026.03.06.08.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:43:02 -0800 (PST)
Date: Fri, 6 Mar 2026 08:42:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mounika Kalamandala <mounikax.kalamandala@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com
Subject: Re: [PATCH] eal: clean runtime directory files on exit
Message-ID: <20260306084259.02a70675@phoenix.local>
In-Reply-To: <20260306060822.328329-1-mounikax.kalamandala@intel.com>
References: <20260306060822.328329-1-mounikax.kalamandala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri,  6 Mar 2026 06:08:22 +0000
Mounika Kalamandala <mounikax.kalamandala@intel.com> wrote:

> Add cleanup of EAL runtime directory artifacts during rte_eal_cleanup().
> This removes runtime files created during initialization and ensures
> that no stale files remain under /var/run/dpdk/<file-prefix> after the
> application terminates.
>=20
> Update the documentation in multi_proc_support.rst to describe the
> secondary process lifetime requirement when the primary process exits.
>=20
> Signed-off-by: Mounika Kalamandala <mounikax.kalamandala@intel.com>
> ---

AI has more corrections here. It does raise the point that primary
process does know if secondary is still running. Also the more unfortunate
and common case happens when primary crashes.

Normally eal_clean_runtime_dir() is called on eal_init, not exit.
Also, clean_runtime_dir does a test flock() of the file and will
fail if it is in use, so it may leave things on shutdown.

Overall, this patch is a no from me.
---

**Patch: eal: clean runtime directory files on exit**

## Errors

**1. Runtime directory cleanup while secondary processes may still be runni=
ng (potential correctness issue, ~60% confidence)**

The code unconditionally calls `eal_clean_runtime_dir()` in the primary pro=
cess cleanup path. While the new documentation states secondaries "must be =
terminated" before the primary exits, the code does not enforce or verify t=
his. If a secondary process is still running when the primary calls `rte_ea=
l_cleanup()`, this removes runtime files (the config, hugepage info, socket=
 files) from under the secondary process, which could cause crashes, SIGBUS=
 on hugepage access, or silent corruption. The documentation addition descr=
ibes the requirement but the code provides no defense.

Consider at minimum logging a warning if secondary processes are detected a=
s still active, or skipping the directory cleanup when secondaries are stil=
l connected. A best-effort check via the mp socket or `/proc` scan for proc=
esses with the same file-prefix would make this safer.

**2. Ordering: `eal_clean_runtime_dir()` placed after memory detach**

`eal_clean_runtime_dir()` is called after `rte_eal_memory_detach()` and `rt=
e_eal_malloc_heap_cleanup()`. This means the hugepage mapping files are alr=
eady detached from this process, which is fine for the primary itself. Howe=
ver, the runtime directory also contains the mp socket and config file. Ver=
ify that `eal_clean_runtime_dir()` does not rely on any state cleaned up by=
 the preceding two calls. If it only uses `internal_conf->runtime_dir` (a s=
tack/heap string, not hugepage-backed), the ordering is acceptable =E2=80=
=94 but this deserves confirmation since the function wasn't previously cal=
led at this point in the sequence.

## Warnings

**1. Documentation says "must be terminated" but the patch creates a new fa=
ilure mode rather than preventing it**

The commit message says the patch "ensures that no stale files remain," but=
 it also creates a new hazard: a clean `rte_eal_cleanup()` in the primary n=
ow destroys the runtime directory that running secondaries depend on. Previ=
ously, stale files were a nuisance; now, a primary exiting with secondaries=
 still running actively destroys their runtime state. The commit message an=
d documentation should acknowledge this behavioral change more clearly, sin=
ce operators who previously relied on secondaries surviving a primary resta=
rt will now face a harder failure.

**2. RST indentation suggests this is inside the existing `.. note::` block=
 =E2=80=94 verify placement**

The added text is indented with 4 spaces, matching the indentation of the p=
receding `.. note::` directive content. If intentional, this is fine. But t=
he content describes a general lifecycle requirement, not just a note about=
 device access options. It might be clearer as a standalone paragraph or it=
s own admonition (e.g., `.. warning::`) rather than appended to the note ab=
out allow/block options.

**3. Commit body starts with "Add" =E2=80=94 consider whether this needs a =
"why"**

The commit body describes *what* the patch does but not *why*. What problem=
 was observed with stale runtime files? Under what circumstances do they ca=
use issues? A sentence of motivation (e.g., "After unclean shutdown, stale =
files in /var/run/dpdk prevent re-initialization") would help reviewers and=
 future readers understand the necessity.

## Info

The subject line is 42 characters, well within the 60-character limit. Tag =
ordering and format are correct. Copyright year update to 2026 is within va=
lid range.
