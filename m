Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838BACCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7255D40268;
	Sun,  9 Nov 2025 15:42:04 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 02B7B400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 15:42:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 0FB2F87
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762699322;
 bh=47VrqSa5GJjJ/VDDx7EJZzoNyRD4M3HDgeCuKxdarlE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kOD1cYhitzNBSrgQCLTicarfaPqU5cRgEL5k5y+potjKPFsM+NcLkcKui09O/dGX/
 eUTSY/qQcYOnQ0n3t9w+RVcVQIaFrorKLkkNe3l1HTPCnt9A4OvSeK1l8kymFwQ/bt
 o1ilQdZ4ccTgdBz/hp/IZbKQutumtRo5O0l/IShM=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 0FB2F87;
 Sun,  9 Nov 2025 17:42:01 +0300 (MSK)
Message-ID: <2506bb2c-2dc0-4f3c-8e54-25f5a9949462@oktetlabs.ru>
Date: Sun, 9 Nov 2025 17:42:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ethdev: make representor parameter more explicit
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, rasland@nvidia.com, thomas@monjalon.net
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20251106055246.360824-1-getelson@nvidia.com>
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

On 11/6/25 08:52, Gregory Etelson wrote:
> The current format for a port representor parameter is
> '-a DBDF,representor=pfXvfY'.
> That parameter syntax describes port representor relative to
> PCI device DBDF.
> In that notation VF Y belongs to PF X and PF X is relative to DBDF.
> 
> The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
> If we want to refer only to VF Y related to PF X, the parameter must
> be '(pfX)vfY'.
> In this case only VF Y representor will be probed.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

