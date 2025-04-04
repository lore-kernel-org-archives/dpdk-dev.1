Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3814C36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB97E40E43;
	Fri,  4 Apr 2025 09:39:28 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id DA8D640E35
 for <dev@dpdk.org>; Fri,  4 Apr 2025 09:39:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 0439541
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743752367;
 bh=TxzQ1M4dQbVoxtgjNdpNUZ4g/rZRrSPTXCpu8zmGjP0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SZdRaJQmE+VMiMqphEsB5uz3IlvQk/X9KDwUNM4V7V94Ax+9bN8UmZQYKVpEw5fqz
 pwgmoxwayyKvpiBPPyE3eKwhsLsp1Alhz9DNZeVP1ALt0gsyKBqLELBBCcJI1hNOZ0
 sZECJEJvzuDm8nSjZvLcbEEfbGoxpviVpSMCm+iI=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 0439541;
 Fri,  4 Apr 2025 10:39:26 +0300 (MSK)
Message-ID: <943e0cd3-1178-40d0-8aa8-93602f5b5994@oktetlabs.ru>
Date: Fri, 4 Apr 2025 10:39:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/10] drivers: remove use of term sanity check
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Liang Ma <liangma@liangbit.com>,
 Peter Mccarthy <peter.mccarthy@intel.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>, Julien Aube
 <julien_dpdk@jaube.fr>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Christian Koue Muf <ckm@napatech.com>, Serhii Iliushyk
 <sil-plv@napatech.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
 <20250402232441.440346-11-stephen@networkplumber.org>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20250402232441.440346-11-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/3/25 02:23, Stephen Hemminger wrote:
> Don't use term "sanity" because it is considered derogatory.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

For sfc:
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

