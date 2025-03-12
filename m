Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D490C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 19:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45CBF40DCD;
	Wed, 12 Mar 2025 20:38:56 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 227C840663
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:38:55 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4C4FA210B155; Wed, 12 Mar 2025 12:38:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C4FA210B155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741808334;
 bh=DD29QxUmuSQyY6Vv+Mx5zS2rQNWrTJHfHhaJ3vOfwyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CMLxLr8Wcy/rGTxmZt+b7ntHPRCshYLbY6uDCydK3GVbExP0mEtmx5YKGZgont1cA
 EAVqgOw0u++Q4DefiwqqOLXgAfnG1DrXzlj90DmkYyCymByriZrEX1t58PwvwmEeej
 6tWaL8QAJjdOGJMzdbwUDOcWQQdwELn7AYOys6b8=
Date: Wed, 12 Mar 2025 12:38:54 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, dev@dpdk.org
Subject: Re: [PATCH] buildtools: remove invalid option for Microsoft linker
Message-ID: <20250312193854.GA28469@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8yMS4Mq3RD4+9+LdhibVhFfwyZU+F3Z=2+auQu+nYVAMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yMS4Mq3RD4+9+LdhibVhFfwyZU+F3Z=2+auQu+nYVAMA@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 12:53:55PM +0100, David Marchand wrote:
> On Wed, Mar 12, 2025 at 2:53 AM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > When compiling "drivers" directory with MSVC the errors below popped up:
> >
> > drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
> >     missing ')' before '('
> > drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> > drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
> > drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
> >     missing ')' before 'const'
> > drivers/rte_mempool_stack.pmd.c(1): error C2091: function returns function
> >
> > The fix is to use common macros compatible with MSVC.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Out of curiosity, did you try dpdk-pmdinfo.py on generated binaries?

That script does not work on Windows. It depends on ldd and ELF binary
format to extract info from the binary. I'll see what can be done there.

> 
> 
> -- 
> David Marchand
