Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F24C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 15:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A664026F;
	Fri,  3 Jul 2026 17:52:36 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id AFBC84003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 17:52:34 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso694579b3a.0
 for <dev@dpdk.org>; Fri, 03 Jul 2026 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783093954;
 x=1783698754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcSla4EbviSS8Vc0jmoLxHAOt0wojeaquoB1oFFP8Qg=;
 b=r+BaFM4NKS8SQ9PqjhIPk19L+w+TZN4r+uGYBh+9+8lp8UyoC+SUhIVuW7Vc67JUws
 KRtYSR1orhbQVe8NQPpEW/IBhh1wpXGh1DvDRVjcztfWZxy5NyzQZpZJIUCxBHV/VFdS
 zrzJUEo43qs7EK3TOol5Q2CB+Q9H1VBMiCe3lC4T1XMzAXG1L1KJPENO3Ok+J5DcvLMf
 7WscNMGyKJgIr7YbTpkFQdmjwqiM0V3k9y5+VdVljR4YYU5UNvObbPWcPoju9uAdNaEB
 43ltKMaS6K0xOlWky5jvcr87o4QkVOR4SWOuHRo7wiOF/5PVT72miDPPMjLaArCiSc4R
 HMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783093954; x=1783698754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VcSla4EbviSS8Vc0jmoLxHAOt0wojeaquoB1oFFP8Qg=;
 b=ftV5K7bYucqclbhUnYvgjGjYeb05zID6ZjxPFof9Im7CuFzQI2pxWCyuYTjAhAO2GE
 DHtn9LSAKpjGWfrfubkLDCaEo79LNtoifGNpBk7PG2Y7oR/vkroNBXa0Z7KKV9INvqnp
 E4e6NgoXzCuUqGrMUwT3SrC+rQ6JdDBJvqhPOPxD0Dy5ekspgA0CMxMv436xmyc2BKd1
 S77QW/fVc5BYZZ3mkFXESU6eFnp755SsadHHQZ9vKh+AdRwJaNR0tsej0R9slW0kMWku
 1Xh4qW15FKSWKo0nzhL1Sitqse0zIms79GSSMLMOn/4a5kQ7gnc5qgVWs7MPccPTENmQ
 lh7Q==
X-Gm-Message-State: AOJu0YxmQ2hSIIxTXErM86iBfjKDwsqpK5H7DG2NKvWXd1w6Vd5cYsY4
 XDghzfEOqX+JGRcJ/tFdxQNkQSYSjp89rgJJlvlyTEf2PqpcVLDQqL2e4jHeQxXq0MQ=
X-Gm-Gg: AfdE7ckNJwUZzYbCqSqA9LgDI/Nm+FM9zjmXmHiWsKQptqO/VuNeLpf56QVfnKD+c2v
 0OdsoqnupbyrStmqJEp/EVuDWnnYDBFiFow7/oeqQ8fJ5z/9y+hkI4+UpZelSpMSWy9Ubk34re9
 Kq1Lb1shY8CiqjY8GT6UJpzUodVG2zxOSL9BJHLpDjBpqAHYY/EA4xif/NEh5ffL5jY9MqPrXlz
 wVrKhWXxCwAl9JqFeVH8yNDGDxhZ3K3kYZ4pNrUsblOtTNMVbOSb8qEh4D+qEXenqCOnqmY7D+B
 7NOQ+WfzmBtOqWLBIFmx6N7Pe7zA/jw0cuCEZsZ7/EzV3Wxtyh8etW3AhdPUN/rYrK2j8p9WRNR
 GGIF55FRUWNUv34RBRqbIDngX2ikUDOgg2fLsOdKBD+aDKkl4F9bw1E9AzuyfBv0rMC5xfj6yd1
 Yxc7XSOeRpmShX48bZydEq9KMWmgEHHPu7f4QAHraLKaj5J9kdYDQeoA==
X-Received: by 2002:a05:6a21:a393:b0:3b7:99af:2d22 with SMTP id
 adf61e73a8af0-3c03e2933edmr3509637.19.1783093953816; 
 Fri, 03 Jul 2026 08:52:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f31e7a2a8sm6199973eec.25.2026.07.03.08.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:52:33 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:52:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
Cc: dev@dpdk.org, pushpendra.kumar@tieto.com, reshma.pattan@intel.com,
 stable@dpdk.org
Subject: Re: [PATCH] pdump: fix request timeout on unresponsive secondary
Message-ID: <20260703085231.67faa7ea@phoenix.local>
In-Reply-To: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
References: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
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

On Wed,  1 Jul 2026 11:32:57 +0530
Pushpendra Kumar <pushpendra1x.kumar@intel.com> wrote:

> When a primary handles a pdump enable/disable request from a secondary
> (e.g. dpdk-dumpcap), it applies the callbacks locally and forwards the
> request to the other secondaries before replying. The forward used
> rte_mp_request_sync(), blocking up to MP_TIMEOUT_S for every secondary
> to acknowledge.
>=20
> A secondary that is attached but has not called rte_pdump_init() never
> registers the mp_pdump action and silently drops the message (logging
> only "Cannot find action: mp_pdump"). Commit c3ceb8742295 ("pdump:
> forward callback enable to secondary process"), which added this
> broadcast, appears to assume every secondary calls rte_pdump_init();
> when one does not, the primary cannot tell it from a slow or dead peer
> and blocks for the full timeout. That delay pushes the reply past the
> requester's own timeout, so dpdk-dumpcap reports "Packet dump enable
> ... failed Connection timed out".
>=20
> Forward the request asynchronously with rte_mp_request_async() so an
> unresponsive secondary can no longer block the reply; a callback logs a
> warning if not all secondaries acknowledge. The forward is still issued
> before the requester reply, preserving the ordering from commit
> 928f43e3f9c1 ("pdump: fix race in disabling").
>=20
> This slightly weakens the happens-before guarantee: the sync call was a
> full-acknowledgement barrier, whereas the async path relies on AF_UNIX
> SOCK_DGRAM FIFO ordering and the single mp_handle thread processing the
> forward before the reply that triggers teardown. This suffices for the
> disable race fixed by 928f43e3f9c1, but reviewers should confirm they
> are comfortable with the weaker guarantee.
>=20
> Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
> ---

Yes this looks like a real problem but not sure if this the right fix.

More detailed AI review says:

Review =E2=80=94 pdump: fix request timeout on unresponsive secondary

Warning: async forward drops the acknowledgement barrier that
928f43e3f9c1 depends on.
The fix in 928f43e3f9c1 was ordering: forward to secondaries
before replying to the requester. But the safety came from
rte_mp_request_sync() being a full-acknowledgement barrier, not
from send order alone. The primary blocked until every secondary
(dumpcap included, since the broadcast walks the whole mp socket
dir) had actually processed the forward and replied =E2=80=94 only then
was the disable response sent back to dumpcap.
rte_mp_request_async() only guarantees the forward is sent
before the reply, not processed. And the two messages reach
dumpcap on different paths handled by different threads:

the disable response wakes the thread blocked in
pdump_prepare_client_request()'s rte_mp_request_sync();
the broadcast is handled by dumpcap's separate mp_handle
thread via pdump_handle_primary_request().

Nothing forces mp_handle to run the broadcast before the blocked
thread wakes and tears down. So on disable, dumpcap can free its
ring / drop the mp_pdump action before it processes the forwarded
request =E2=80=94 which is exactly the "Cannot find action: mp_pdump" /
missing-response window 928f43e3f9c1 closed. The commit message's
appeal to "AF_UNIX SOCK_DGRAM FIFO ordering" doesn't hold here:
the reply and the forward travel on distinct sockets to distinct
consumers, so there is no FIFO relationship between them.
For enable this is harmless (callbacks are being added, ring
already exists). It's disable where losing the barrier reopens
the race.

Info: the underlying problem is enable vs disable asymmetry.
The timeout bug you're fixing bites hardest on disable (dumpcap
^C), which is also the one path that still needs the barrier =E2=80=94 so
"async for enable, keep sync for disable" doesn't fully solve it.
Worth deciding whether the right fix is at the mp layer instead:
the root cause per c3ceb8742295 is a secondary that attached but
never called rte_pdump_init(), so the primary can't distinguish
"didn't register" from "slow/dead." Broadcasting only to
processes that registered the action, or a disable-side handshake
that doesn't block on non-participants, would fix the timeout
without weakening teardown safety.

Info: the "reviewers should confirm they are comfortable with the
weaker guarantee" paragraph reads like an RFC note; it shouldn't
survive into the permanent commit log if this is applied as-is.
