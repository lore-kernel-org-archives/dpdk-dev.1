Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323AC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E176402F1;
	Wed, 19 Feb 2025 17:50:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D33EE4028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:50:02 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 35997203F3DC; Wed, 19 Feb 2025 08:50:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35997203F3DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739983802;
 bh=T1tY8uCZhpY4tLgfTraCJhTENOJ8NfL3EsIeYwCsf/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rxmyqy/EgfnJ+/rkLvLSweFvzTO0bhF4Q3x17+UQJmgsRVtOAGyLZUSbsVm+6m94M
 2xPEgB9saxG/cQbRaQMXh/Kfl82QQ+hZws/uWtPnbky1XIlI0oqqVrRELufVL9RxNO
 rTqMrTHbZRIUwE/JKIAGS/ufojiE9VRn7oRemMpU=
Date: Wed, 19 Feb 2025 08:50:02 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>,
 stephen@networkplumber.org
Subject: Re: [PATCH v2 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250219165002.GA6472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-2-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA4C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA4C@smartserver.smartshare.dk>
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

On Tue, Feb 18, 2025 at 06:12:04PM +0100, Morten Brørup wrote:
> > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > Sent: Tuesday, 18 February 2025 17.32
> > 
> > There's no MSVC equivalent for compiler extension __builtin_constant_p.
> > EAL already had __rte_constant which was used as a first attempt to
> > workaround __builtin_constant_p when using MSVC. However, there are
> > pieces of code that would benefit from being able to provide a default
> > value to be used instead of it being always 0 like how it was done by
> > __rte_constant.
> > 
> > A new macro is added here allowing such default to be provided by the
> > caller.
> 
> NAK to the new macro.
> 
> Please use the sizeof() hack suggested by Stephen to provide an implementation of __rte_constant(e) for MSVC.
> Here's a link to an example of the hack:
> https://news.ycombinator.com/item?id=16720172

Thanks for the link. I tried to use the hack as suggested but turns out it does
not work with msvc. It results in error C2100: "you cannot dereference an
operand of type 'void'".

I'm open to further suggestions.
