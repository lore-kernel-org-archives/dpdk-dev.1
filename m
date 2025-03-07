Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5487C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 08:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E024029E;
	Fri,  7 Mar 2025 09:08:12 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 4491040275
 for <dev@dpdk.org>; Fri,  7 Mar 2025 09:08:11 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5278885z8616066,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
 s=dkim; t=1741334888;
 bh=X9eR5aVcaD3rHHh9CKtCuj3cBElca6/dgwA0iB6RBfw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=Ay6IFk6D5/xG1ro1ETwHdLsQk5l1uBf7ODLZhw6+PHdbTGDT5mOg3Ag3O+ZsYPPuo
 BHhTiRUru6dBP7H75ZFwN+fyhTRIYS7OPJpVwKjtnY9DujODYUb5IZWGFe3O3SCrkm
 XznqbknF/CvNyc5rFGPJV5z6/+S07zIBG1jUTENGjDkQz6wX7MyK71f2mAlOv9xC6u
 8XvGBOkaIKdy22nLAvgTnBM3A/FeprxELXBTgG7PPat59eH8e3gqwbeMWx3TjFNSn2
 ILLuY5hQjWN0S6B80k5RnaWDJfRTdVGzkQJRveEvo3909SmvbgAdazVxvZVJVnhsCA
 u4kEr+4rsRXyQ==
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5278885z8616066
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
 Fri, 7 Mar 2025 16:08:08 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Mar 2025 16:08:08 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Mar 2025 16:08:08 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <andremue@linux.microsoft.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: Re: [PATCH v2 2/2] drivers/net: remove use of non-standard array
 range initialization
Date: Fri, 7 Mar 2025 16:07:48 +0800
Message-ID: <20250307080748.5206-1-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1741190802-19486-3-git-send-email-andremue@linux.microsoft.com>
References: <1741190802-19486-3-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Acked-by: Howard Wang <howard_wang@realsil.com.cn>
