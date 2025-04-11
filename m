Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185CAC3601E
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 00:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0474340687;
	Fri, 11 Apr 2025 02:06:57 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3078340285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 02:06:55 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 673C62114DAC; Thu, 10 Apr 2025 17:06:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 673C62114DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744330014;
 bh=TMMIDzWco3FJXxgtluwDZJw+jzfVcdQBGhA8XqwrAVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J9QtYRBKukxqeFFhN7UJq6W8PV1pcfX/D3uxBW6+1N2auKYxFp+kxxXeifzJhLsWc
 gu2F2ahB7JjYo4h03KHkSlwMUywsSI5ev2OJm1oiXxcsBM+gvw9IF6vVwNEyAF/Cyt
 QD7N6pjUGYZHxrwKpki2WC4wc1cXmTHXPv8NgtC0=
Date: Thu, 10 Apr 2025 17:06:54 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v6 05/10] test-pmd: avoid undefined behavior
Message-ID: <20250411000654.GB10978@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-6-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8xqEk=qgJteUDv0TJ9W_UyRoOtjVSU7NjkHrUVvgrHgYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xqEk=qgJteUDv0TJ9W_UyRoOtjVSU7NjkHrUVvgrHgYg@mail.gmail.com>
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

On Thu, Apr 10, 2025 at 06:05:10PM +0200, David Marchand wrote:
> On Mon, Feb 24, 2025 at 5:25 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > Compiling with MSVC results in warnings like below:
> >
> > app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
> >     directive in function-like macro argument list is undefined behavior
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >  app/test-pmd/cmdline.c | 12 ++++++++----
> >  app/test-pmd/testpmd.h |  2 ++
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> > index 2afcf916c0..d0b47eac8f 100644
> > --- a/app/test-pmd/cmdline.c
> > +++ b/app/test-pmd/cmdline.c
> > @@ -8980,6 +8980,14 @@ dump_socket_mem(FILE *f)
> >         last_total = total;
> >  }
> >
> > +#ifdef RTE_EXEC_ENV_WINDOWS
> > +int
> > +rte_trace_save(void)
> > +{
> > +       return TEST_SKIPPED;
> > +}
> > +#endif
> > +
> 
> - I don't like this fake declaration.
> It does not comply with this function documented API.
> And there are other stubs for the trace API in eal/windows, where this
> could be a better place.
> 
> - TEST_SKIPPED 77 is some known error code when invoking unit test via
> meson, which does not make sense with testpmd.
> 
> 
> I sent a simpler fix, could you have a look?
> https://patchwork.dpdk.org/project/dpdk/patch/20250410160237.3067629-1-david.marchand@redhat.com/
> 

I like the solution you proposed. Thanks!

> 
> -- 
> David Marchand
