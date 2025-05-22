Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B860FC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 14:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B16BB4060F;
	Thu, 22 May 2025 16:51:44 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1761E402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 16:51:43 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E9C4E211CF90; Thu, 22 May 2025 07:51:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9C4E211CF90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747925501;
 bh=cj/JbCUyNBib/uXntPI88HkdUh1Fy/XuILg0n7pG/BQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FR0FtCIP0SsthTQaw78RbnpL0xYDb+7r9/kcQUM8b7i/uS0TUqxo5MPfU3W3hC6ez
 TpwAeshFiNEtTukqift9yzwLDtVHNNcYZEHMWz9ivwLEwFpHH9+vRIfMN5NrnFSjIF
 v9IW5P8N43cdThoVlQF1IKCpE6xoanYYBzXcBAVs=
Date: Thu, 22 May 2025 07:51:41 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: eal patches with other licenses
Message-ID: <20250522145141.GC20088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC86@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC86@smartserver.smartshare.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Thu, May 22, 2025 at 10:29:46AM +0200, Morten Brørup wrote:
> Andre,
> 
> Please try asking the respective original authors of getline() and asprintf() if they are willing to license these functions to the DPDK project under the BSD-3-Clause license. Or perhaps generally offer dual-license with BSD-3-Clause as an alternative to their original license.
> 
> -Morten

I sent an email to them. I'll let you know when/if they respond.
