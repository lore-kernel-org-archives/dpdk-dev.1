Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAD606C489
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=IGEH5t3h
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B1B040682;
	Thu, 12 Nov 2026 15:01:46 +0100 (CET)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mails.dpdk.org (Postfix) with ESMTPS id E4367402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:01:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=245; q=dns/txt;
 s=iport01; t=1794492105; x=1795701705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZoDhI7gkiqu+cYqAqPNrqKsa8Ot5zn3DI++5Akd08Yg=;
 b=IGEH5t3hUd+O4LNV182HDA5JhOXdvGOcFhqJCb5LEsWIOcRRYHwRRKRU
 UJm+xG0Y8Rs1E8Atya2ahU2/+gaO/pgC4hg3fzzVrZEaii+Q+hiBMzO2E
 Tuk0XRAodrZJQ4TSyEP/EakJ3SELeTUzuRMoWdjdphJOp0/pXQe0aF/bE
 nQ63dRLSoUvnjTVhYQF8c52B9NsqkS9dsDfS6hn2bg0PR9d31fGNDPXNf
 0hsiHnE807I0QnOklXj6xCU4idvim+U7hV6z7CLR1FztNWpQgouR+uaxz
 UKlmSdVf7ERvBIU1lVqht54vvwSZSr48b3zf7LWLj8UF4lkP98C/UkpdK Q==;
X-CSE-ConnectionGUID: hikcnnqtSJ63G+gXTqKSRA==
X-CSE-MsgGUID: sXRHztwNTZS+EUYknhOqgQ==
X-IPAS-Result: =?us-ascii?q?A0CDAABVxvVq/4sQJK1aHQEBAQEJARIBBQUBgX4GAQsBh?=
 =?us-ascii?q?CxChSCwGYF+DwEBAQ9RBAEBhH0EAgICjh4CJjYHDgECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQoBAQUBAQECAQcFgQ4ThlyQEwIBAyMPAUYQCxoCJgICRhAGgxWCdQO6c?=
 =?us-ascii?q?3qBMoEBhH7ZS4F0FYEKLgGIYQGBcYQIG4RiJxUGgUlEgUeCej6IH4JqBIIig?=
 =?us-ascii?q?QyXZglJeBwDWSwBVRMXCwcFY0JDA4EGI0sFLR2BIyEdFxEeWBsGBRIgKkBDR?=
 =?us-ascii?q?AQTgRKBBV2BKyhdAQIfRi0VgXUCglGBI10CAUlBDgdFUwklQxJHJCIIEgkBE?=
 =?us-ascii?q?xosCoEaNTwJJj8VDFsMCxoFGkcIAgsCDHQoERATHR4kLwUaJj4bCn5tPTcVG?=
 =?us-ascii?q?QQ9lkKbSIwogiGhEYQqmlAJhx8zg3EBpwCZCKlFgW4BNYFZTSMVgyNSGQ/gf?=
 =?us-ascii?q?CZ0BwIHDwKTcQEB?=
IronPort-Data: A9a23:w1iu1qrJXbgrCYd2vqD02k0otl9eBmJMZBIvgKrLsJaIsI4StFCzt
 garIBmOM/6JYDT3fN0kYNm390hU7cPTndJhTQU4+SFmE3sS9+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8jhfngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfva8Uk35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0uZ2AmpI8
 +UEExJTNT/AiNKK2ZGAcMA506zPLOGzVG8eknhkyTecCbMtRorOBv2Qo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwxGYH49tL/Aan3XaSFZo1+9rqss6G+Vxwt0uFToGIqEJ4PXG5gEzy50o
 Erdz17ZEA0FEuCt8nmoz0OvgO/ohCzCDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWQM5SM
 0wZ/AIooLQt81aoVt3gWhe1ujiDpBF0ZjZLO+Q+7AfIzu/f5ByUQzBeCDVAc9ch8sQxQFTGy
 2O0oj8gPhQ32JX9dJ5X3u3Mxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:VWHMrKo3NbyfogcZp53hjvUaV5oLeYIsimQD101hICG9vPb1qy
 nIpoV/6faUskdyZJhOo7690cW7K080sKQU3WBzB8bHYOCZggqVxehZhOOI/9SjIVycygc378
 hdmsZFZeHYPBxdkdvw5hW+HpILxdmK973tuMLlpk0dKj2Dr8pbnn5E4sHxKDwReDV7
X-Talos-CUID: 9a23:2m+RqGOXVVpUQ+5DWChk/0gSA9weUCOG4zTfE3OhKl1TYejA
X-Talos-MUID: 9a23:McHijgR0QQMBtJ+XRXT3tAtCJtt3xZicMwMgrKQFvcmjLCNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787011200"; d="scan'208";a="895756599"
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
 by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Nov 2026 14:01:38 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-02.cisco.com (Postfix) with ESMTPS id 44DC818000223;
 Thu, 12 Nov 2026 14:01:38 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/1] log: add name query functions
Date: Thu, 12 Nov 2026 09:01:37 -0500
Message-Id: <179449209764.2.16070142550751479350.0000-dpio-773-maintainer-follow-up.patch@cisco.com>
In-Reply-To: <179269447225.66.503181230751464930.0001-log-add-name-query-functions.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
 <179269447225.66.503181230751464930.0001-log-add-name-query-functions.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-02.cisco.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

Could you take a look at this patch when you have a chance? It is still
applicable, and the automated checks are green. I'm happy to revise the API
or implementation if you would prefer a different direction.

Thanks,
Randy
