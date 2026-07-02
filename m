Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222EBC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 21:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0036C402D1;
	Thu,  2 Jul 2026 23:08:09 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 7658440041
 for <dev@dpdk.org>; Thu,  2 Jul 2026 23:08:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 0181FEC0109;
 Thu,  2 Jul 2026 17:08:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 17:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783026487;
 x=1783112887; bh=SW6NCVkVMlYqh+Odlmrq2BDz7moreUZ7tW1M/VNFMfA=; b=
 b7pxivwfUSuzfMseq9b/sl/Y36ZRcy434p31vpZ02kn4hPAr9EznztX8Wpk7WoyV
 OVQyzLQOkC7GEb7QgA8+RFGeXjh2Zq0W8Vb7qv3snT64SbyTcDKSIv1/1mruruf3
 WGXLFulMsOtHgD8TRklpYvdgkUibYeR0apc3Y1gFhbqtwPMKHXcOlyalbOdofrGs
 0iI+v0sXGstkmzm4vCkZDQcEsj7YdREtnZzCRQKSQJi8chXln9KIkrCGWwJ/jcx/
 vRj2Kb15nVW2d/5uM8ba9mJDK2yFCXUJytrZfm3bQcTOzRwXfkPyp3DcALM2Evp0
 i0L3iyqlMTb54DH3H0FvHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783026487; x=
 1783112887; bh=SW6NCVkVMlYqh+Odlmrq2BDz7moreUZ7tW1M/VNFMfA=; b=G
 hpY3VXgPhUFF11tlYLSh6elmFSGF+6zUv4pGQlFBHLB8jOW574K0t7C2XV7BlUyG
 vDPgFJ/qZn2iAVAtfrsfxGtxKzNppiEZLDNb/wlc+c2bwFfGbqGTJbyiecdS/oHs
 Lfc6qxkn0Z2XBL7BNbBOHc5qHZ7TpJ3kZ2C3F0K+dmX+VmsyAoRqec1mJuxOFkL6
 XODlwMcUIvWdKq7xU8ai7QYjX7RFaXEjl61DHbotKtKLmJ+Pp8mlkVGktGz5984e
 BvH7xmQ42QM0LQRckBQ1bLTsl5L6bYN4vbrgELtM1YF4fLPb3YgZXn2zTc4qLGr9
 3Ze7l5OoN76Wb5Znijktw==
X-ME-Sender: <xms:N9NGatIy4nV-T922BjeqlYOxFUNi_gyPbWB8ZFMYbgWL7qv28EKupA>
 <xme:N9NGatc6KP6PMbUr9GSZs4Y-cL0IT1kzbPz13edd4sJPxGJqJ7YZTWa0n_REjuNk5
 SBfEJr3y9t1kCHvITOcdbJdNcnpWP8_Nsln4eDdFvAsZbFfuhhCTQ>
X-ME-Received: <xmr:N9NGak3qxufVasd_juO4-0tuPezkE3Iex7oG3IVpqw7YvioouejUBFkdPiw1xnLAxzms8OQc8U67uxLW_RwbxTXV0g>
X-ME-Proxy-Cause: dmFkZTGqKZgH3CCMHiztReY8WAgonMEDL3p4dKB0w4siZ7zXNLb0a3rnhykqfAKhMzRT3J
 eVI23XgYt44mgjVzKkP/vcFfjxM4mGYWl4ILojwdhhe+9RrAxdf0U8AOZPP/ECdHC6Uvrz
 8qWfX4Jz+8THNQdm7+rNKfFJGWL7gOB7s/MduVxE6xPiZsiAD34FaLAgIOZR1kOAGizUEs
 7LfhQnF3IoiuPs8NRnetqhVvngfRinxXxHvIbWaeyZdb38d/FCk3OQOg7rcKYd6lDZnbmD
 iflmKsGmiw0AN50etZ7dc3/K1I9zLRmEi+qBhaT6B25g75J58tNXqgYdEEBoipjvYhGccP
 b1g1jMJSIzUWsZArrnAewUTOdaL99Q1BGzgeyPMShdELq0X6fd+p3Pal1Dx3KoLpjyaq2w
 asQDpREogEmhLrNP9hOAAyjSIAk4OzjrfDQSsVtPp48YSVJecx0Lm6heUCASDCDG454X9w
 AlV9oepWJVpl/2Jk3FGknmshwK6MdXCFvPnHaTryDYQH43JbjjfPcToPOOxyHckUX9vqi4
 4tZnTD5pUCSbZ8k50ams6PDf5Dsvgrr1XTa/5iNTnZf23vm19gpjLzjg40MFkAMX5/V3+x
 lu0mp/bh2Won9Of97FKFEMuHsZPZsU0jke6kk2uNAmjOt+QSibbkU8j2A+sg
X-ME-Proxy: <xmx:N9NGamjoAN2XbDF-T37ny-ZbE6ulAt_scJ5GG7ujk4d62FtjcLCTPA>
 <xmx:N9NGaqRsjo6XlSwkcYtGEQvglJiuEfIkAk5zm2YG7IFsMkBHl5GqVA>
 <xmx:N9NGangdOvADYf7FHPwV1_Rw2cdSt2FP3Ee_k2OQTFR1uM6YhP-NVw>
 <xmx:N9NGaq7XOSQRBeKZBiboysPCPS8nFNi9XJNpofjAW7-x04Y0UrtJvQ>
 <xmx:N9NGat2qXVAHZA8EE8pJ3H2oDRoO7BSBtXpl848THmjcLvmi2mBazOvH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 17:08:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH] test/pcapng: add some leeway to timestamp test
Date: Thu, 02 Jul 2026 23:08:05 +0200
Message-ID: <aJNiDZd6TG2RYMG2NiwY4Q@monjalon.net>
In-Reply-To: <20260701223702.105995-1-stephen@networkplumber.org>
References: <20260701223702.105995-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

02/07/2026 00:37, Stephen Hemminger:
> The timestamp test sometimes fails on busy or emulated CPU's
> add additional slop to allow timestamp to be up to 1 second
> after capture was stopped.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



