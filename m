Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2AC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59EC7427E3;
	Tue, 29 Sep 2026 15:58:23 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id BEC9D4013F;
 Tue, 29 Sep 2026 09:22:07 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1790666525; h=from:subject:to:date:message-id;
 bh=XvIAIctJVCQlg4FNXb49bvqgLb0pH5i+REIiviFf7xc=;
 b=L/n5Bn/xNsVbWMcOb+GruxxsaAmaFHW+7f3MvSD+AVKTTNrPjLKTqS9NlY45MaB78Je3N4FTR+Y
 bj+b+aM1yv84wOOwFr9b3xE0y9d8ca6n9dJa6CDzDGna+8OOUESA49Nl7WLWULPbcgaEMmmC+xb87
 ZluT7bpswiBqPKJ8M1jMBoUvNudJKbiyztjMpVPdRN3Ikx3kWXER1a/ROmWHrcr5XK7yB54lH8uJb
 5cbkrLz243TMhFeASFDbT2K+Yamwgokbwl2i6w0jTeixwEtVIhTDMMaUYrh2vvl9MDuhbG48f8Vzb
 6I1+mM21ik1EpnAXmDJfgObZb016aEVi7j8w==
Received: from localhost.localdomain (192.168.0.250) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 29 Sep
 2026 10:22:02 +0300
From: Aleksandr Khromov <haa@amicon.ru>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Stephen Hemminger <stephen@networkplumber.org>, Robin Jarry
 <rjarry@redhat.com>, <dev@dpdk.org>, <konstantin.ananyev@huawei.com>,
 <olivier.matz@6wind.com>, <sdl.dpdk@linuxtesting.org>, <stable@dpdk.org>,
 <rrv@amicon.ru>, <haa@amicon.ru>
Subject: Re: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Date: Tue, 29 Sep 2026 10:21:53 +0300
Message-ID: <20260929072153.56119-1-haa@amicon.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <HTNMG94CQuKiMcKhE4so4g@monjalon.net>
References: <20260918074729.79205-1-haa@amicon.ru>
 <20260921141515.759647f5@phoenix.local> <HTNMG94CQuKiMcKhE4so4g@monjalon.net>
MIME-Version: 1.0
X-Originating-IP: [192.168.0.250]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Tue, 29 Sep 2026 15:58:22 +0200
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

On 28/09/2026 16:18, Thomas Monjalon wrote:
> Should we merge this patch and expect another one for the endian issue?

Yes, please apply it as is. The byte order problem is a separate,
pre-existing bug that only shows up on big-endian builds, so I would
rather fix it in its own commit.

I will send a follow-up series with two patches:
  - net: use rte_cpu_to_be_32() for the next header in the IPv6
    pseudo-header, as Stephen suggested;
  - net/hinic: same fix for the copy in hinic_ipv6_phdr_cksum().

Thanks Stephen for the review.
