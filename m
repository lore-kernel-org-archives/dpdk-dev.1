Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C2C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 14:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F0740280;
	Thu, 27 Aug 2026 16:59:52 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 3921940150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 16:59:51 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so51634a91.3
 for <dev@dpdk.org>; Thu, 27 Aug 2026 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787842790;
 x=1788447590; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=arKb/ycx+gIE91IoByaTK8CecSQ8KD/d3coP5URzthQ=;
 b=knJRh3tXjMLdxgXbtiMmGRhaR6UGUyDqQ5JjnrJslHFKlPOaSLmd2CR/GfKRFPsqCD
 IZZqBwdncYXvd26qGHgT7sepQsaiF87OdHbzpSAQbSqW+fzjWqrbN2Jm3AOkiXH8abFY
 nilwawWmxHfhbXzoO8/llEQ+eR1mN34UXZnQEsvgkEmG6EKx6yh3o23x9i4/VtJHa0qv
 Wqa3XJYqCoPgysPx7VmKOry04QzaFwPMKUPQRljpSIKEEZ/ovpDiw/nbz5rabKsaVt0/
 OP5TfD+4VPAVK4059sOm4OEXOgI5Kb1+K62jVcvJZIwTL5SYUDGhKgZyi3Bnd4jq/tf5
 YZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842790; x=1788447590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=arKb/ycx+gIE91IoByaTK8CecSQ8KD/d3coP5URzthQ=;
 b=AWDHhyctNxfHqueiNFsp/0gwBbGF/3c1BPBYMOJ8CnVUh+m/R/gqX0XrBEkONbvrqP
 87Tgz2yuBY3weQsz5CF3UHSgMbk/+71ClGxcOiciipYLBN3t9Pwjsc1VxJF57odQpKPx
 mybiFn+pDWp2IiuegTnO5x+K6MewPXvw4ft3G8gItgp9ca1Z6Qn5SSfkh8V5vHuti0JU
 bsI5ptJSW5qCxmS3KA66ZfrIaOwchh16tXxoObTPkeg12JPZd5+FGUxVrvc9OwS610OR
 Vkxm4j4Vfk7GfhH66D6DWBGT6j7Gwq/DsTWdiRR7igORCF8bkpGCE/yC+QXPqWtGok7U
 jjkw==
X-Gm-Message-State: AFuF++kTPCQ6BfLFhgfjEPzHnBT/aC3VcpSLIUcu5MjT9IBxn2fp9iQd
 vDb3DDWeRxsk1OxASElRassOY8op2dwejDfLCO93cs22t5N53pt+RMcDBke14zsCdpI=
X-Gm-Gg: AR+sD11sUvLRrsD1ynduhvsvtZ8E3StFJkDCJjaMg7VG+ZvFpfstZcWrwOGvFgc70km
 RZZuzTiBYyHbHTJs+Tjnhl+zwDxShH6dZDw4gqsB2Asd+NewyXBP0UH7MCQLQ9+qH926pupNxKW
 dGLJJ9qdLFJrZVWCNd5fhe3ZH2rdoB3s3nPLXoOpHp/ooMAfNzVPW6R1P9TdN8UYPkfCowTvayx
 TpKUwVWeppe42M863pyT7Tpyz5NogoIMBpwrz1pZBNjTsxLNEWVj5Pft7ky4m55yZkrr5+Clkea
 90H2de31k3uKKX0oR16p5jirgCBLGmwXqNmG1xnHtZVC24XZVo0pTFAiJ2Xq/OinFXHGFobfDKC
 EFiS3WfMcxL3uFyO6FXiz2GDxCjEEDUXkL4bjPSehEZPr6Y6Bi8ayY6I2g3u/rekOE0N/IF35Pf
 1QBIWHX8Zhvoc0oRNo/PV4NoE0ojLWuJVBGWYCAb+NARtENcHBUGivMHfh0J5sV3Iyktqum8OeA
 Phbt0VWLpEAY7G8biANyqboyzO4ww==
X-Received: by 2002:a17:90b:586d:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-3966d491c45mr33764680a91.16.1787842790156; 
 Thu, 27 Aug 2026 07:59:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a905cf38sm26369642c88.12.2026.08.27.07.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:59:49 -0700 (PDT)
Date: Thu, 27 Aug 2026 07:59:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Devendra Singh Rawat
 <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Rasesh Mody
 <rmody@marvell.com>, Igor Russkikh <irusskikh@marvell.com>
Subject: Re: [PATCH 4/4] net/qede: remove unused app version variable
Message-ID: <20260827075940.5bafd493@phoenix.local>
In-Reply-To: <CAJFAV8xy6SKarAo6Vx3VA4Cnv5c3o=crOzvH3_u64XLH8GW7HQ@mail.gmail.com>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-5-stephen@networkplumber.org>
 <CAJFAV8xy6SKarAo6Vx3VA4Cnv5c3o=crOzvH3_u64XLH8GW7HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 27 Aug 2026 11:08:07 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > qed_dbg_set_app_ver() validates the caller's version and stores it.
> > But the variable s_app_ver is never used in DPDK driver.
> >
> > clang 23 reports:
> >
> >   qede_debug.c:820:12: warning: variable 's_app_ver' set but not used
> >         [-Wunused-but-set-global]
> >
> > Remove the variable and the dead store.  
> 
> Maybe go one step further?
> qed_dbg_set_app_ver() looks useless.

Yes it is useless code. Looks like inherited from Linux driver.
