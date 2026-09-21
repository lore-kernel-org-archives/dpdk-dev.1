Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A0C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F9EB42E36;
	Mon, 21 Sep 2026 17:55:07 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id BB6CE42D66
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:55:06 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso2446628a91.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006106;
 x=1790610906; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GcLXnpHHwiGBpV7bXxoglkuDN2UoS6wMREQYJJc7UT4=;
 b=zeqPOaNjzDEPuy4DhRBg98f+2d3Xwbyv4chzA9oNcGQZYN+g4Ui6Y/dOgTnNNTur2L
 RbAv45jezceMjKbgPNw6D/OWedzwdcaQHbc5icgAR9V8hTQfrq7mB7xPtajhIIvvjhpP
 BrjeL+pR42lEgExg4HXDKHUpzfitsJ/MPWhtFlCeDF+gwG1Egj2hgITnI5TH5iDD0dBl
 vVbw3P5py+KDrgGnYDcLFSbSeP4v/09Ef/eXllsXLw88XTfnV1aWgalfCvH3dCLMTm03
 1f2lqk9vUK1RbdDXKShoZzYp+gl8SjDz9JWSv7lT3Xsn7wEzYiX2iILhFIOIo5DCfT8k
 WgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006106; x=1790610906;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GcLXnpHHwiGBpV7bXxoglkuDN2UoS6wMREQYJJc7UT4=;
 b=bZIyjRE/n0fHwSq0vzXOUVZlYFIV/2xMzMBE0w/dHU/BMmxysMwJ77CIWZP7kdQkAx
 U/8tkg+V+VushPb/un8X26mIuO3+c6zCcnZO345s42NONhtPyiDEWHi1EXcGp/eJVHF5
 TFiRUxn/BbLhvcqC67BDePf5hntoISdMVTq05a448Lr/psoTNiZRmC/13P4sSUaCndaw
 iU408rghvpaMAbWjBas7ow6seCu05928fg/65wAB2P4Q00dRVrQVLYoTWwlB8/pNLxT1
 iChD7DmmGj7JTSLoKNCaPprLdg7yZIF9Usk9V4jNyUqZDVYNFfpjcSiHPICCojsiNZok
 l1Xw==
X-Gm-Message-State: AFuF++l8o6WgxnCcjwHBIXstwqeyjnmwWKwE53YTr65hZAgzY7iTXcyL
 GDhA3owiOWiX9Xq6E0ZOYAc25hZuDryh7Fdnd6Rwyyhcf2s/H0/yGY0mZd4e9KokzIk=
X-Gm-Gg: AYBFou1H/6y7PLV0K8MEDXfSfxTBEl++nHQXMdkFIaZL6m23+HKYvTC5RJ/kk4Wt+ei
 /zifWDKwdcLz0tFDhw8J1JVDQKiX73X926AMie4en5CNvNNelnGYB+s4orUoIxn9P9GBA4uR4+0
 Aw1sZGDJWHZyL0P9+CCXnFuw/rsASWHlC3ZGlgl6ls047NFk14au/+Dqf2ZwNpCXC4K+0SUR9bl
 OnxFCzWkFiFn+ICmHhLUjN/Z23WflUn9djtSJZftlXl1ZWaTYrRZxRMgziLF9mE14tj4bMqg9i8
 VAfALHouLZkJ0kcRcNb43JSKtGK3NSL92eReGgGtLdWY5H8wvkngN44VYhBEKBwBSQ5Ewh1c7Hy
 Wp84P3VdZZqatq+mLfxuNkIC0U22gPZFcwkWT9GXTFg7x/tl1wvm8Ks1MheFWBMZV3o1bggQWci
 qQacZJDaCScTJOpG65sSDeCpIsZb7RGlGknEOIdlmW3XTrdFTB9+To2rkCydqU6fg+uILBkGxka
 5xjcXzAcB/FewVzm6i9Yk8VVfWqAg2Btx8+8Zlq
X-Received: by 2002:a17:90b:3fcc:b0:39e:4546:fb13 with SMTP id
 98e67ed59e1d1-39e54d3599dmr17449880a91.19.1790006105903; 
 Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:46:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org, Dakota
 Sicher <dakota.sicher@broadcom.com>
Subject: Re: [PATCH v2] net/bnxt: fix flow create segfault
Message-ID: <20260921084603.795173f8@phoenix.local>
In-Reply-To: <20260921021817.1033783-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921021817.1033783-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:18:17 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> When creating a flow that requires a destination queue but none is
> specified in the flow create command, find_matching_vnic() returns
> NULL and the code falls through to insert the new filter into
> vnic->filter, dereferencing the NULL vnic and causing a segfault.
> 
> Check for a NULL vnic and reject the flow create with a clear error
> instead of crashing.
> 
> Fixes: 59119d49529e ("net/bnxt: fix flow create when RSS is disabled")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

Better AI review flagged an error here:

[PATCH v2] net/bnxt: fix flow create segfault

Error: new vnic == NULL branch corrupts filter lists when
update_flow is set.

When bnxt_match_filter() returns -EXDEV it has already done
STAILQ_INSERT_TAIL(&vnic->filter, nf, next) on the existing vnic and
set flow->filter = nf for the existing flow. If find_matching_vnic()
then returns NULL, the new branch calls bnxt_clear_one_vnic_filter()
and bnxt_free_filter() on that same nf. bnxt_free_filter() memsets
it and links it onto bp->free_filter_list while it is still on
vnic->filter. The existing flow is left pointing at a recycled filter
whose HW filter was just deleted. Before this patch the update_flow
path went to free_flow without touching vnic. Gate the new check on
!update_flow, or handle update_flow first.
