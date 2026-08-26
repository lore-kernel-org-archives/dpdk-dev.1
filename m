Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44405C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 20:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 146D640268;
	Wed, 26 Aug 2026 22:49:45 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id EF87340264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 22:49:43 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d710632717so11107375ad.0
 for <dev@dpdk.org>; Wed, 26 Aug 2026 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787777383;
 x=1788382183; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lV/SQMiKSqZbDurHxlIyWgGtikB8BLkh+pVE9Bsy4lg=;
 b=mGw04SsVNJ4mKQHuJa9BVXKxbY9EnqPMfug3FFgITKD5y6BdFKF8s4ASzj+gO1/zj2
 nRhWX8tx+ZKQRyWu/0YqyLH9oAdtXJT4YzM5JBLmhXztXDcY+7s3zkHbN4nh0HcfbL3n
 xY4vNu+iPSloDFIVf4uc3/m6wuMYPvcz6iL4rbhsUXUAEubleux/8nxCJAgycXrkp3jq
 dJsJynAyXrAWVhwXIak9rwopc7daE1VmtIoITIR4T/97B1Qdrh9MKBcS3eMv9gU4kRyY
 zClWydbpM1z4QhDTBssASEH/GlEfKwKFrExxr6PTnSP29B2VNi0Y9xDKFJ2MGqAaFWPG
 lgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787777383; x=1788382183;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lV/SQMiKSqZbDurHxlIyWgGtikB8BLkh+pVE9Bsy4lg=;
 b=n+LKGr4r3zkPOwlX+jB+7OIlLuHA3v6dVIsG8GfQJaWp6d12vg/LztfZGjtAJ2OPWz
 TdLVjmPLjFFSLTm6Dmrej8ngzK5sInXQXSNeAYQc9wAdpq/SO43HhaK5crI2w62BA67+
 4DCXt9JiOEiwznxwsCjhgSq9iXBB0G5Cglz8+ioxqbucoxmyG/KYoHRfuaroNJ74Ukuw
 ha52uHEPhvE39fGrjnmt4RqV3TrEbOZCf/aqExNbfIxcB4gjdEUS38V6OC3R5qa/YQzV
 C/jbEuiPwwZdtJVUHKsWO6qHE2KD/UcZpYc33ah8rwqTWqTL60+5zabTizRW8PDMiRpn
 y5Ow==
X-Gm-Message-State: AFuF++nDj8dwWPOJS1rrIf2AEheabrVeTaMN57DbgQxNgD/rf4uwpZoT
 gVc25f+qNlQm8YowJQFMgzqu48GLCZIUqtmA+WbSWm5Gd6Lorn/uoDAPM/3GE+Bhgy4=
X-Gm-Gg: AR+sD13uyb1Bn0ZjpB6cszJgzDeO67xPCS21TuZSuZgYQzFhMTQdjIg1a3wCqas+xi8
 VTfw0LcDKHirjq8eymcgSxD3npQWMTvNM7YnJCylswSjfglpP63RsktgTSuXEpuR1Ks1vCqk//j
 KMAP2f4aWRchHA1OBy3McovS2Ij5OEGsDIASulxb7lfVxk2hz4BbJwWlNXD4BYoQIEuwa7eX3V6
 GtHsGEVUUT2UQhHh+KtWK0CRzUun0lavgRIXvuFEhW32vHkYJEq8SKYIE180iklvvN8eGMvDJp1
 lZW7TZQBfY9dnqLfarSJGPL+xLVEWdCP2YEs4ONzsIRpSIreuk+SLGYJJ8MqhQYHcfWEuCu4s42
 9MEzViongsm8B4BHlJx+1PU77Vkdda71jNPU6tlK1oJ0+iQ2dxwfhRMDIRbjjC5KyIaZjl3gVo+
 NY/iaO0OPJV4FJzWzz7OC3LOTECVs7eEeVUWap+A/VTKpRJ0A4Jzmh+C4h1833ejuF5F/NQB739
 s/UjF5QgP9KxdJXdWVn6BGL218wQOM=
X-Received: by 2002:a17:902:cec4:b0:2d5:c099:16e2 with SMTP id
 d9443c01a7336-2d707b6cd1emr147258325ad.13.1787777382826; 
 Wed, 26 Aug 2026 13:49:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70497753csm11180805ad.18.2026.08.26.13.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:49:42 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:49:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix use-after-free
Message-ID: <20260826134931.14aea946@phoenix.local>
In-Reply-To: <67906e589460e28a3f08d3a28c02d9ceeb72c2fd.1787745917.git.anatoly.burakov@intel.com>
References: <67906e589460e28a3f08d3a28c02d9ceeb72c2fd.1787745917.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 26 Aug 2026 13:05:27 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> When unmapping a device, the device is not removed from TAILQ, which may
> result in attempting to access this devices' data during subsequent mem
> event callbacks (as they are only disabled once all devices are removed).
>=20
> Remove the device from TAILQ on unmap to fix it.
>=20
> Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> Cc: dimon.zhao@nebula-matrix.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

AI review found another race; the close needs to happen after the
removal. Like this:


=46rom d138d13ad3bc03d0b032aba593283f49ffa64b97 Mon Sep 17 00:00:00 2001
From: Anatoly Burakov <anatoly.burakov@intel.com>
Date: Wed, 26 Aug 2026 13:05:27 +0100
Subject: [PATCH] net/nbl: fix use-after-free

When unmapping a device, the device is not removed from TAILQ, which may
result in attempting to access this devices' data during subsequent mem
event callbacks (as they are only disabled once all devices are removed).

Remove the device from TAILQ on unmap to fix it, and close the device
fd under the same lock so a callback cannot use a stale fd number.

Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
Cc: dimon.zhao@nebula-matrix.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl=
_common/nbl_userdev.c
index 96f0d2e264..ec6840d60e 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -547,8 +547,9 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *ad=
apter)
 	struct nbl_common_info *common =3D &adapter->common;
 	int vfio_group_fd, ret;
=20
-	close(common->devfd);
 	rte_mcfg_mem_read_lock();
+	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
+	close(common->devfd);
 	vfio_group_fd =3D rte_vfio_container_group_bind(nbl_default_container,
 						      common->iommu_group_num);
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
--=20
2.53.0

