Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91600606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hJTP/Eni
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E817640285;
	Tue, 10 Nov 2026 15:32:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8B1A840281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:32:42 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE481477;
 Tue, 10 Nov 2026 06:32:38 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9BEA3F632;
 Tue, 10 Nov 2026 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794321161; bh=X8928lKEU99dJkPBxIcT8QvVR3csk8B/V+v5FKTMuEE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hJTP/EniMRzQ2r+E6FRCII+0SaOnCN/HSGfjpRdDpM1NPXEytSDw4y2PZZb20I7w4
 wJwrERchPoq6CfQ4QZpNAXmeBoRkuNS0z4hUVAPtbkq3WJ38Ln51h4zkLc7RtYsy63
 K3j6oEINyBM18+ruBYiuKFzm1VvIEM2T6HE455Kg=
Message-ID: <970e3674-a306-4478-99c3-e095d4434154@arm.com>
Date: Tue, 10 Nov 2026 14:32:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dts: add ipgre test suite
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260327180232.443820-1-abailey@iol.unh.edu>
 <20261019194841.890257-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019194841.890257-1-abailey@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

looks good. Was just missing the latest addition of @func_suite. Fixed 
and accepted.

Luca
