Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC95CCA462
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 23:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F802400EF;
	Fri, 16 Oct 2026 01:37:00 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1A8D740041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 01:36:58 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8819033dbadso3876360b3a.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792107418;
 x=1792712218; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bw4Sf5X08scvqQAGYSGeF6ENuwy5p9e7VwLoU0T8+Ec=;
 b=In39bOB7CjhgJScM6CVm6Qe0H4wEhrEXRoyov7rY2nxLXGgZOAbblDtkPV9VV+/vfa
 wYaCilciOBesjkJYk5vjGRFy4WzcYtZsgwLKrUWZZOCbXK1GfisLNdgG4pWzYnx8dBs6
 ebHzaNSbGMdmI649kShhEkmkJ7045+SB4W3VP4rXl3qVnrrZGhVcilqm27B+yRfW4PYg
 A3AUOjJb0dMEMFVB0x9YHrAmxs2TRYXxATCuWVdNG4VmyTNkokjhXIiwaDM2CjlUN37p
 Zj3WPUrdAYkeR+mds6zJEztlcMWPIvhO5k6dndOkhNAeo74I/64kiqbdNC82AXMEjZvo
 fb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792107418; x=1792712218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bw4Sf5X08scvqQAGYSGeF6ENuwy5p9e7VwLoU0T8+Ec=;
 b=I/XblRY15W7o9sk4+XqXueA9GMIGUzpIEq6eTNtweRMLL5XeQj4o9ED9QVvXfcNZ0W
 fdlVKk2wC5yQu1bFkG+pLG4Wo1umK72SRfI09qT8Alyh7wpqG+YNeukfuQKMNikcgKPP
 wDMb7y2AKZg9+x88uyFjQsk02SL1dLP4Jr8s8bwFG3nLxqSFW+Km0DBpMOTrqiije3s0
 3FV3IiZxGmtOq3ZH+W7c6QA1lk3961VOO+/cD+bC3KMsud35JediBFa1SgsOxw/1PtQ6
 iThlz4bxHLmddlwa0pu4tB/u+WNzpch/ap+p2kKHtF8YlraH1JAnSiJjvszE2A5uxtJd
 D2iA==
X-Gm-Message-State: AFq9FYLfup67/aGptVU0enRcqTS/SY5uvGUQfbjKqVFzSQXPh7YXhvzd
 zHyy5ViaJDo+IQOX0s0RaKZT7vGYD2dsSjQQueO3QC8G+9BNIMRpPqMzmnnVjYYRJCQ=
X-Gm-Gg: AYBFou0BUVuxsVEPw6E3u1H7cRJj+ApChv/cQ1WIhaOO32qV+49VudpjrgYFolYsIc4
 ouEOJduUnbYQ5aG1tHJojIkYOJf9mYJihkZQrisuGaKXTiCyZHs3hTnLsWijVZC9qGQm3L/aaIS
 E2ZM6cFtUxwsoZTTyYZFSJEm9AAMFYBAPlrAA4DSnjpmVX6F2Ky+7n5LB/kRTnxludDotU+ASta
 AIZWeJLQ8R2R4u4aje194KXc7H3dAugYG1QHcwMkuLMZtk9rDuhMAuQR3XejeVeiMHKYCRra9yk
 QV1EJnFBLMdByDR8LKSEbDOMjy8SMapTUPD6eD3FQiMNqnWcQdodhwY7J8rvqWWNfLo+GXgkz84
 13fOJVGZVpGYN2KPYopMwK7AX7Pe9XvHTIcAuZxV2+D8CJ5gqdsUgj2B8U6GyGEruDdDBVCqh/a
 pibFn3556qoEUwT1vyIzxQWPJtywh3XNfLq211JrfKnvNEeQFpajZy6Yhf93xiibfQqHJD7Tp/9
 hegrx/UN2txiw51XaNlvxmy6I73MBCPl0axslY0gA==
X-Received: by 2002:a05:6a00:3694:b0:899:55e9:8806 with SMTP id
 d2e1a72fcca58-89955f90940mr13818883b3a.22.1792107417155; 
 Thu, 15 Oct 2026 16:36:57 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c8b922sm247584b3a.11.2026.10.15.16.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 16:36:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:36:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v11-S2 10/11] net/dpaa2: remove unused soft parser driver
Message-ID: <20261015163654.56a86df9@phoenix.local>
In-Reply-To: <20261015092513.2427856-11-prashant.gupta_3@nxp.com>
References: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
 <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
 <20261015092513.2427856-11-prashant.gupta_3@nxp.com>
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

On Thu, 15 Oct 2026 14:55:12 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> From: Jun Yang <jun.yang@nxp.com>
> 
> The DPAA2 soft parser (SP) byte code has to be installed by the boot
> firmware before Linux starts; the WRIOP parser cannot be reprogrammed once
> the MC is up. Loading an SP image at run time from the PMD therefore never
> took effect, so the loader and its DPNI_SS_INGRESS plumbing were dead
> code and are removed.
> 
> The rte_flow VXLAN and eCPRI pattern items were only ever accepted while
> an SP image was believed to be loaded. With the SP gone they are rejected
> by dpaa2_dev_verify_patterns() before the configure switch is reached, so
> their handlers dpaa2_configure_flow_vxlan() and
> dpaa2_configure_flow_ecpri(), the switch cases that call them, the mask
> descriptors and the VXLAN_HF_VNI helper are removed as well. Both items are
> also dropped from the dpaa2 feature matrix so that the documented
> capabilities match the code.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> ---


After applying this to next-net, I reran the set of checks.
But this patch causes problem:

$ ./devtools/check-doc-vs-code.sh 
rte_flow doc out of sync for dpaa2
	item vxlan


Backed out the whole series, update and resend.
