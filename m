Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FD606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=e7QtEIxr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B163402A3;
	Mon, 26 Oct 2026 17:51:17 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 540A640275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:51:15 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so20650665ad.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793033474;
 x=1793638274; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EVCeUeDUEyBLL00PME5EAVaxJ+KlfvlmF1EGd7shscg=;
 b=e7QtEIxrNSM5hzNl0/Rj7kQR4dN6R3PKa9WAhSoK5tGwT7mHdmH3Gc1HKJUCg9I6vP
 iPpkQtpwD0rh/oTvdluScDBBUQ1j5ct0QQoTzybuaz+N2BA8T2DVjtUDTnmM9T2NB2/v
 Gw3yIwhoXprTQfM5rVrfnirS6rjd5wa1sHeZuUSi2WDLyLqiM2KnmlGZvg6EHcnYZF7e
 4yn+b8o7kat+jYzZyLtCflm4jdH041OG4zOO0EJMapZ6pBceI2Ok2/bvlGU2A3fmT36+
 qPom7IGfygwLIQ8oU+nhGBl40OkMmCCq2sYLJQUID18V7bm0SKBbOf4XIIfBIpS8FU5F
 0d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033474; x=1793638274;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVCeUeDUEyBLL00PME5EAVaxJ+KlfvlmF1EGd7shscg=;
 b=uYXGURb2LWRA/fQfxbpH9UB4YjbDGfmOQ9smz2cWFC7xAJ3Y7iHZZiifeF52nx7RkB
 BHVs2Mx59M+h+64Y8SvkxPlKvqk0v9hReJudyVkfG3zWfep9w5pjQH5St0KskJEOHKX2
 /CAlF9IYEnToY+ZNbmh7+BxihW+CKmCrS0wlsyF2XQ3ISvnODbV+NiP9QlvoAktmeomA
 cL9kd3E5uFyPYdteZtl016T/RpzVEMUxXnSexEVQRZcfFOom3KVZJLjnHJv7u/AAmtkG
 qfeGzPkXp4M54dyLpJUj8MGenFj/gUDDattyGbYCNdHpuZ3xpIBywQp1eTCK5+oNbZwg
 0A4w==
X-Gm-Message-State: AFq9FYI4fMdsV5vettO/+p7DsuF2n1OaaVVVR271CmlfogHVunTm8J7i
 U59hIQMIbGBJPlA4vC0kVDQfl59msjm+i7M/1m71gumqlM+VKg5j5pxmSCHbNyXWYh0=
X-Gm-Gg: AYBFou18ZpndiMU7wzMTEj2B9hwEPjj2vukd/v5PiqApVALdxFaD6pDSAPZRej9F8aD
 iuVqvgeb5Au2aR2LngjOj28q/UPsK61ANHsVzG2rWLGpvoO2NnP/pcFO/nNtl0w55weuzGtIauH
 AJH8QRogulya9m6xGIHExlBkRok0yjQrzpDK0SO1OIYS3I8LDY7ZUnZ4VPaw7gOTBCc3JmKI/kZ
 Mg8tKz+srMrtSPX3GjmwVCaYQa81d0vVH2wfZBU7Wv3IZoK6XlYJytFF0gecrmgQBtvCXJ4Cyhp
 1Y5m/aneOfswAa8AphoHpMygdQ1cmurWlYm+vyYTnuA3/ZZUO6M8FncDJT7Py6dm0LQNe97twgE
 jl0Tx3eTpyuUFFIGS+Ro2fAxx9EftWNgEGJg2exT/eoZePnOZQT+hCc6cH3Pjl1Gi7iJvZLE3pw
 Eq3MbM2LYPxuvx3zLzMk+ZnUP1b0hKe65aRKKX3Fw2H+u5nmM6E5v/hrm3Yjdk2cBJxI5hlJdNN
 lbk8VU1xjrvhSDtXjY80jZC7W1GLk2ZFhHJ1IeQhZriz3ob8VeOoOay44uaERzl0mzuc9KI1eyl
 vxxsIh6K2xRZKYyXKSOJNg==
X-Received: by 2002:a17:903:244b:b0:2e9:ca71:45f4 with SMTP id
 d9443c01a7336-2ea9c63ca94mr58070285ad.33.1793033473619; 
 Mon, 26 Oct 2026 09:51:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9af31421sm20461545ad.7.2026.10.26.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:51:12 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:51:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 1/5] ethdev: fix flow conversion with null buffer
Message-ID: <20261026095108.7ea124df@phoenix.local>
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1792849824.git.anatoly.burakov@intel.com>
References: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
 <5698ccb3daeebd1d50346d5a3bd8471468056463.1792849824.git.anatoly.burakov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 14:50:28 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> rte_flow_conv_pattern() and rte_flow_conv_actions() document that the
> destination buffer may be NULL when the size is zero, which is how
> callers query the number of bytes required before allocating. Both
> functions nonetheless walked the destination with ++dst in the first
> pass and dst -= num before the second, regardless of size.
> 
> Pointer arithmetic on a NULL pointer is undefined behavior, and is
> reported by UBSan as "applying non-zero offset to null pointer" for
> every RTE_FLOW_CONV_OP_PATTERN and RTE_FLOW_CONV_OP_ACTIONS size query.
> 
> Keep the destination pointer fixed and index it only inside the
> size-guarded writes, which are never reached when size is zero.
> 
> Fixes: 063911ee1df4 ("ethdev: add flow API object converter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Manually run AI review sees some problems.

Subject: Re: [PATCH v3 0/5] ethdev: flow conversion fixes

Series applies cleanly to main and each commit builds with
-Dwerror=true. Descriptor tables now cover every item type through
COMPARE and every action type through JUMP_TO_TABLE_INDEX.

One correctness problem in 3/5, plus a pre-existing out-of-bounds
write on the same code path that should be fixed while here.


[PATCH v3 3/5] ethdev: fix missing flow action descriptors

Error: SHARED is now accepted but its handle is not preserved.

The new entry is MK_FLOW_ACTION(SHARED, 0) with a comment saying the
handle is stored in conf as for INDIRECT. rte_flow_conv_actions()
only special-cases RTE_FLOW_ACTION_TYPE_INDIRECT. SHARED with a
non-NULL conf falls into the generic branch, rte_flow_conv_copy()
copies zero bytes (desc size 0), and dst[i].conf is set to
data + off, a pointer into the output buffer instead of the handle.

Before this patch SHARED was rejected with ENOTSUP. After it,
rte_flow_conv() and rte_flow_copy() succeed and return a corrupted
action. Handle it the same way as INDIRECT:

-		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT) {
+		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT ||
+		    src->type == RTE_FLOW_ACTION_TYPE_SHARED) {

Either that, or leave SHARED out of the table since it is deprecated;
but then the completeness test in 4/5 needs an exception for it.

Please add a SHARED action with a non-NULL conf to
test_flow_conv_actions() and check out[i].conf == actions[i].conf.
That would have caught this.


[PATCH v3 1/5] ethdev: fix flow conversion with null buffer

Warning: INDIRECT conf write is not bounded by the buffer size.

Pre-existing, but this patch rewrites the line. In the second pass:

	if (size)
		dst[i].conf = src->conf;

Every other write into dst[] is guarded by size covering the entry.
With actions { QUEUE, INDIRECT, END } and size equal to
sizeof(struct rte_flow_action), the first pass writes only dst[0],
then the second pass writes dst[1].conf past the end of the caller's
buffer. Suggest:

-			if (size)
+			if (size >= (i + 1) * sizeof(*dst))
 				dst[i].conf = src->conf;

This also covers SHARED once 3/5 routes it through the same branch.


[PATCH v3 5/5] ethdev: add flow item structure size query

Info: the NULL name checks added to rte_flow_conv_name() and
rte_flow_conv_item_default_mask() are hardening for the strlcpy(NULL)
case described in 2/5 and 3/5. With those two patches applied there
are no gaps left, so this is fine in a feature patch. If you want the
check backported, move it into 2/5 instead.
