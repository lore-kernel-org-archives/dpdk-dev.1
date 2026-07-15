Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A847C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 06:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0F3540615;
	Wed, 15 Jul 2026 08:32:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D57C24028B;
 Wed, 15 Jul 2026 08:32:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F3lOvm1893076; Tue, 14 Jul 2026 23:32:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 RbA20tb14M4ssWILKr9IniPuBfbspaKhLWiQ+J++k0=; b=OSePUEQaepAqzOA0J
 KA7KFk6O90OnC4cmA7zFC0fU8X3UuFX+7tfBQ/LTLMm5M9V69XTolHwiIbQKF+Y2
 rq4MXTO3z9BCFZ/llGQa8fXxuv71X/pmaw7vlaljqeXbIOgtWAG3MeBroJ8p0h1n
 AzhigTW4N5mSF6sS4RIYrVochcOEqHLjNNpZc3FbPwfGIEC0bRUmuKbyGaS59Doe
 t6wN/UOfSvvbvidfAwwK5PnpE95o+vtDPJi3FDpVa5/7VY9Jyo4rb0bQBVN+HCjY
 nSgeWb8zz9IX4RrOV81Drh6GxjAdb8+vNYBemKJlyf86splL7vp+JRkIzkTZY+oc
 o1InA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdkdc3gjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 23:32:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Jul 2026 23:32:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Jul 2026 23:32:21 -0700
Received: from cavium-System-Product-Name (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 573C63F7063;
 Tue, 14 Jul 2026 23:32:18 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <rjarry@redhat.com>
CC: <Andrey.Yudin@infotecs.ru>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <kirankumark@marvell.com>, <ndabilpuram@marvell.com>,
 <pbhagavatula@marvell.com>, <stable@dpdk.org>, <yanzhirun_163@163.com>
Subject: Re: [PATCH] graph: fix xstats of cloned nodes
Date: Wed, 15 Jul 2026 12:02:15 +0530
Message-ID: <20260715063215.3892836-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
References: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfXycmwRd9JO0mR
 bxO1QCTGUcNru426RS6m7yD1b0+lhDyw7sG8ZXra8rTqWNNiPACt7fkDNQXzm8sSwOXGKnY88Xi
 bNcV6dsxWkC//YqtiWbTRSW2wE9yU1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfXyLU0c4JgSy14
 0AVjVqLbCY6xsUciZnNZW7SYEdYpUvNpstUyfAChVBCXBl4zd4HhX5I6wozqQNfc58PedXDwyI7
 XW9uqqUgXXPiuz5omDmA58nCsIik24qVjG/7XcdwQE/cAxhAIfCWXsY0NJ1oFZmgGKXRdKXiUe9
 JzLicUrjkYHkyA4m8XyqJ/UVjeuViQSOreGXoIg9ok9Om9z10fbpBO5raTu1EsFIrKnpDVK00qQ
 r79BIgOFN8m2LhK/BdUakrERFb79BUzqXH1j6mjvLm5nvs+KMZ/vCLRgmrucGG65nAp2EkRdA1G
 6UOuUiv+mIdWiuCyyzFTdPW31rYxKgy3AjkCTrNkHs3M0VQ5LKwRZ9C/5e6qbNU3pCSkyL/gQ3A
 HErFwbMneAws6mqut/AbyU/1+j4sujY6x4TSDw93tfkY/u/qfX13bPc3IzUsNrZ6Km2PffCN7kd
 Unx1Ik4PlqrTXNpkaGA==
X-Proofpoint-GUID: CIEK2kESzd73CyKkjjVCHSee7BzxH0Os
X-Authority-Analysis: v=2.4 cv=WsYb99fv c=1 sm=1 tr=0 ts=6a572976 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=OYpW40nrAAAA:8 a=M5GUcnROAAAA:8
 a=CNtU9eUxWR3NwhCjJjAA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=S9TJFf_bQE4EeFseXdJy:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: CIEK2kESzd73CyKkjjVCHSee7BzxH0Os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
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

On Wed, Jul 08, 2026 at 11:14:19AM +0300, Andrey Yudin wrote:
> When cloning a node with xstats enabled, xstat_desc entries are copied
> into the rte_node_register structure, but the nb_xstats field is not.
>
> As a result, the cloned node reports zero available xstats,
> making xstats unusable.
>
> Copy the nb_xstats field when cloning the node so that cloned nodes
> preserve the xstats configuration of the original node.
>
> Fixes: 070db97e017b ("graph: support node xstats")
> Cc: stable@dpdk.org
> Signed-off-by: Andrey Yudin <Andrey.Yudin@infotecs.ru>
> ---
>  lib/graph/node.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index 1fce3e6632..bb39c616de 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)
>  			goto free;
>  		}
>
> +		reg->xstats->nb_xstats = node->xstats->nb_xstats;
>  		for (i = 0; i < node->xstats->nb_xstats; i++)
>  			if (rte_strscpy(reg->xstats->xstat_desc[i], node->xstats->xstat_desc[i],
>  					RTE_NODE_XSTAT_DESC_SIZE) < 0)
> --
> 2.47.3
>

Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>


