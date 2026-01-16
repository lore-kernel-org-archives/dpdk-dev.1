Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA4D4A61A
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 09:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81EC4427B5;
	Fri, 16 Jan 2026 10:42:22 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id CA5114060F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 10:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768556540;
 bh=qI6GZMWvcPTSuv4Ok3xyobsBTlnusXErQehu1VB5ysI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=G/GQR8pXsWuq6fPtBpqrioOGfVntyki7vM5Xfdk8xLV6DadXTUG+E6Oi4Z9hKwyqH
 vdcRkhyoEeyYezka6tpKaK21xRlFTOpu3kH1gSkC4gI2V4v2I/1U+g4h3UESNFaieS
 Y6fZyB428O6y+7pGxc3/JhsLxsK8rUQ53i9MKlv/3uKGZJ7Uvbcd//nVGAEzYjSr3x
 EXB7PSM0FRB92SRpArBPCK4z3jByIuCP4HET1iQlECEE/m21jVNABZwQ2cIJGoL6It
 rvPihZdM9SOQvMDtYgLPWBReqsGkAiUfBHb36Ji3kwJzS/KLYumTMIzJkCqpp/H7z4
 9uZOKZA3k8FXQ==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 82A401180078;
 Fri, 16 Jan 2026 10:42:20 +0100 (CET)
Message-ID: <03920b87aa9203f2e9eae239e2fd1a9811f6bfdd.camel@cesnet.cz>
Subject: Re: [PATCH v2 0/6] net/nfb: code cleanup
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Fri, 16 Jan 2026 10:42:20 +0100
In-Reply-To: <20260115214849.623db82c@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260115144040.345873-1-spinler@cesnet.cz>
 <20260115214849.623db82c@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
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

Hi Stephen!

Thanks for quick review, my reaction to issues:

1/6: The log message at line 543: fixed
2/6: Still missing NULL pointer checks: misleading,
     dev->data->nb_rx_queues ensures the queue[i] was inited
4/6: uint16_t: applied, Doxygen comment: fixed
5/6: extra blank line: fixed
Those fixes will be in v3.

3,4,5,6/6: I think don't want to add Cc to stable, if you agree?


Besides that series and 'net-nfb/rework to real multiport', I have
another 3 series of a similar size that depends on those series: Native
Queues, Metadata+Offloads, and Ethernet. To make the work easier, would
you prefer to have it in one 19-commit series or should I to continue
in 3 small series?

Thanks! Martin
