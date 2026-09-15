Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D0EC88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D0440B91;
	Tue, 15 Sep 2026 17:38:37 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 5E16D40A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:38:36 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747f01363so24503325ad.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789486715;
 x=1790091515; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OL3ohLNIBTMBVhnGq8PkECNIsFdP7MljFeWRbl0S570=;
 b=O+J9PP1M2dm+TQyso8o0oqMJt05+4brXcmVTK8aROwq9w662JhjmcvpTe8Hkwp7SG7
 +DJWXVNxcMNGl/rlo3d4hFkeQSUWZb41x8SMbHrvgsm1hblUt8oyimcQ2x83mJkBkhhv
 S7FAQk2F2eNks04EW/azTBr1oFj94nqZ08u+CoqHhPX2nrEop8vnmgtCCl2nx9bXB0Bb
 g0NfhqHmODa3UPxtm//pKZJrbJ5mCy7DNIqcInGk2OycBqrlum/7otYyYBmabL930HG5
 8WCDOHXj150hs3o4PC/Xa+9cbra6A/5luXcPXH6Xbd+lrg+q0DxgKHjMMjnPAdVxPxFN
 LJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486715; x=1790091515;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OL3ohLNIBTMBVhnGq8PkECNIsFdP7MljFeWRbl0S570=;
 b=Dk1lix/i0Tg6zJZ/3kXnLlnZPYvpuaEiFl7O4ReWi5Cmob83XuKX37k1LEsrHnRrdA
 gmuOnXTMsy3zt48HKfJexXN+gEMu/qvD8Tqe3+Y1p3zdZ9mtlcs4XadKhSpB+4mBXGJA
 u8bQWXe6ILPzXYl115b2aEtVnQH6c0hRH0XtQj72QbQOcTB/YgISEn8usQT6A7gduW6N
 RO+pExZAmdMJgfoApFyLSl/4w0zTaJNzfmIF9hQYan2DbjTPtRIBtjdWT78mtKCt1wbY
 RFsrInNCL3x1RqMBctN7h/jQJmXDYAgPovkczX3zunrho3waJ9hSfo4SSoFozre7Fijm
 BWbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl5ivijAO9a81buHXmpgB7+DCB0rs5sOS+v4TDIxkmk1lJaytvjUAV5336k+tu0XarI7g=@dpdk.org
X-Gm-Message-State: AFuF++maTgDqHKdkZlpAaeNepYvrUWcrwQVdO9b8p/7d/9i3Ny3WY0WA
 q898dMocIbqGB0JM1wG1k3Gfw/dGKA7PYALeG8Ne5VfV9j1oYjDVQyVfBixiNRHYDwk=
X-Gm-Gg: AYBFou2XHjM0tkUWwCrrVHotbn5oelFhaSL6zo+Hec9f7Ma1dMeYLjywQ93rqItaZWS
 PKVyXO3SfbDvLW38205CkE7iyR8Ex6RZmt9iGxMbWFbhwhmukbEj/0v06LB9xqN8YyVX+zZKBVk
 VIErk7HYi3F3Cob6DVBDvZultEq/Smb01ean4jgF7ckVVQuRhfjUgZWwIXUOIVtEoAZPH64jZQv
 59Z2LKc8HG9m18kQ/Jd8Tf6wv4GhlnICuUDr56HG4yDybtkTZD6L9dR0SxGvPUepy720WrB2Le4
 OV2GTI+VE7FenOQg8dTkrJ8kamc8XO01JdkfbFpcgMpWGcN8I2X0+CBkUt6hyCR40YQDrurjMro
 t8JOrzJrGlCyyEtZPlDCIUEVL9IPLZio3Vc4jjWxxlt6qK9eSXvxyy3oiAIcwGCTmYvJIzPiszO
 f9OI9QMaom1VRl/IKm1Y7I5Et/BI2w/ROGr80NznLJjlLzTdeSxpm2ZS43Wf0oaRowUYYmwvt4Q
 3EbmX7VQRvDnRmRX9T3CA6uYQy/8iSBnTD7WJEBt7b1IEB33uI=
X-Received: by 2002:a17:903:284:b0:2d9:2688:8be6 with SMTP id
 d9443c01a7336-2dd6c760336mr149297905ad.19.1789486715200; 
 Tue, 15 Sep 2026 08:38:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2ceb1b3asm69252745ad.30.2026.09.15.08.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:38:34 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:38:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/txgbe: fix leak of filters on flow create
Message-ID: <20260915083828.08bd23fa@phoenix.local>
In-Reply-To: <20260915152436.67378-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
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

On Tue, 15 Sep 2026 23:24:36 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> txgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
> RSS filters into hardware before allocating the software flow object.
> If that allocation fails, create returns an error but leaves the
> hardware filter installed. The application has no handle to destroy it.
> 
> Allocate the software copy first, then program the hardware. On a
> programming failure, free the copy. Set ENOMEM when allocation fails
> so the error path does not report success.
> 
> L2 tunnel add failures now return immediately instead of falling
> through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
> and overwrote the original error.
> 
> Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

Patch looks good, I was going to merge but AI had a couple of small items
that should be addressed first.

Review: [PATCH] net/txgbe: fix leak of filters on flow create
Patchwork: 169627

Applied to main (f43632a) and built with -Dwerror=true, no warnings.

The alloc-before-program reordering is the right fix. The add helpers
(ntuple, ethertype, syn, l2 tunnel) do not modify their input, so
copying the filter into the software object before programming is
equivalent to the old copy-after.

Warning

1. PF FDIR: mask_added not unwound on the new ENOMEM path.

   The allocation now sits after the "A mask cannot be deleted" block.
   When this rule is the first to set the mask, first_mask is TRUE and
   fdir_info->mask_added has been set before rte_zmalloc() runs. On
   allocation failure the code jumps to out without clearing
   mask_added, unlike the program-failure path right below it.
   A later rule with a different mask is then rejected with "only
   support one global mask" even though no rule is using the mask.

   Either move the fdir_rule_ptr allocation above the mask block
   (free it on the mask error paths), or clear mask_added when
   first_mask is set on allocation failure:

	if (fdir_rule_ptr == NULL) {
		PMD_DRV_LOG(ERR, "failed to allocate memory");
		if (first_mask)
			fdir_info->mask_added = FALSE;
		ret = -ENOMEM;
		goto out;
	}

   Allocating first is cleaner.

2. Missing Fixes tag for the VF FDIR path.

   The txgbevf_fdir_filter_program() branch was added later by:

   Fixes: 7eef71080e ("net/txgbe: switch to FDIR on VF")

   Add it (12-char hash) alongside the existing tag so stable
   maintainers know the VF hunk only applies to 25.11 and later.

Info

3. The commit message says ENOMEM is set "so the error path does not
   report success". Other goto out paths in the same function still
   reach rte_flow_error_set() with ret == 0: the flex_bytes_offset /
   flex_relative mismatch, and the trailing goto out for an FDIR rule
   without b_spec. The memcmp() mismatch path passes a positive ret,
   so -ret is negative. Not introduced here, but either fix them in a
   follow-up or narrow the wording.

4. The L2 tunnel early return is a separate behavior change (errno
   reported to the caller changes from the RSS parse error to the
   real add error). It is correct, but belongs in its own patch so
   it can be backported or reverted independently.

5. Lines being moved anyway can drop rte_memcpy() for plain struct
   assignment:

	ntuple_filter_ptr->filter_info = ntuple_filter;

   Same for ethertype, syn, fdir and l2 tunnel.

6. drivers/net/intel/ixgbe/ixgbe_flow.c has the same program-then-
   allocate pattern in ixgbe_flow_create(). txgbe was derived from it,
   the same fix applies there.
