Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3715C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 16:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D500402CC;
	Fri, 21 Feb 2025 17:47:30 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C20EE402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 17:47:28 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BD33120376C1; Fri, 21 Feb 2025 08:47:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD33120376C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740156447;
 bh=x61jsbnI6kna/qQnM/+E0QcWqtdlq3yJYY8pfE2h5l0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M//r1V5r+cVsqSmSAKB4usMcasJBKfePcjqRpQQqwIBEK9lYaaS3QlqMqmR8Cl+cs
 gXCs3ndx976eB/84o/AAzTEwSEFeg9vOCqswMwWudyiAH2mJWJg3uL5JhgoZEBS24i
 76GqEC6rZ9KwUTu610QHi4IEBs8No0Y/4dyNk37M=
Date: Fri, 21 Feb 2025 08:47:27 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250221164727.GA19864@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-2-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA62@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA62@smartserver.smartshare.dk>
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

On Fri, Feb 21, 2025 at 04:31:28PM +0100, Morten Brørup wrote:
> Thank you for this updated MSVC variant of the macro, and its detailed description.
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>

Sure. Thank you for pushing for this better solution.
