Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5901FD25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 06:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FD8F40288;
	Mon, 12 Jan 2026 07:17:08 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 35F5F4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768198625;
 bh=9snGv3fUfgBHwfQ+Ijm0MXxvnYJ/BcwJ7C0B2xIy44o=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=Q5fPzCkRLMqg/5iChK5HTII6twbq20zemclYfQOhhvT/4TqfD5uTbb2zGRApvFi18
 afaFffltqc1eTfgcigxeKeKHluXKz32cE9R252PAmaleuVcyjHbpEET9m8QgAqsJkX
 w5Q8sSHH66NH/9BMjlFDNxXRuEreENBDhLWsegHV7qKk4Y87sCxPswLSImCE0Sf9Oq
 yUVyi/PgMAxiqhfdiTv+gNWqIzrKqn8A4hRotS2NuX8zeoa4tV/v+M7xuUg7zwaERJ
 YSmMPkgADTUH8rJuUDCDJkbnbNExWbMfdwESWuMmWdNKq7KZZxkX/obN5MnD5LfD06
 GKanXAfAPY7Ew==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D591B11800A9
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:17:05 +0100 (CET)
Message-ID: <5e68b2729f1aed1b123f275acfae4b396d7e80fc.camel@cesnet.cz>
Subject: Re: [PATCH 1/2] net/nfb: remove unused flag
From: Martin Spinler <spinler@cesnet.cz>
To: dev@dpdk.org
Date: Mon, 12 Jan 2026 07:17:05 +0100
In-Reply-To: <20260101181345.201601-1-stephen@networkplumber.org>
References: <20260101181345.201601-1-stephen@networkplumber.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Acked-by: Martin Spinler <spinler@cesnet.cz>
