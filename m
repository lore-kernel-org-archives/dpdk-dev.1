Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDEC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5991040269;
	Tue,  6 May 2025 15:15:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 139CE40150
 for <dev@dpdk.org>; Tue,  6 May 2025 15:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746537335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKbM3PkDlhvKfWa3ipDiLZJkgtYMcD/u479jT7mIc9A=;
 b=O1rGHF+GRWwR7Ce9ha2HYScSNNxMGTZLc89TzrAOlxABhzF7mOVyd/IFtlFA0PE23vEuHA
 3eJigj1B5QVcV1VCsptGV1C+eyOEuZ5Cj6u8qosw+bRkrhpCRXER12mroZ/RcRvi4C9N/D
 8O5rXsrz9VnBXDtOQhWCNeM5dB8QzZw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-6aXftxxJNTqY7nB3mdAu1w-1; Tue, 06 May 2025 09:15:32 -0400
X-MC-Unique: 6aXftxxJNTqY7nB3mdAu1w-1
X-Mimecast-MFC-AGG-ID: 6aXftxxJNTqY7nB3mdAu1w_1746537331
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-54e8141b4adso4260153e87.1
 for <dev@dpdk.org>; Tue, 06 May 2025 06:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537330; x=1747142130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKbM3PkDlhvKfWa3ipDiLZJkgtYMcD/u479jT7mIc9A=;
 b=GHeyA83RsmHzs5Lo9OL4lTzG0oyYoiEK8UjhNVYCr8rNOfYfNW7/dlt3LLrZ72LGIv
 TAc1SZU69rUHMLa+5tjCOO+eHXmUAXsAO29UfzbSMiqjCnmzS51FzDTraULIpYxR/kiA
 1FvCqf3rUc5q9IAj00JlYGj08QhLHDg1RIE1mcAtddEMZJvGNPpgjT50eOMpKkmbSJ2r
 EYi7eK1WOtg9IVtZICTRs73UHv9doSAwv5BAWF8p9awQVfV1qtwhcFUS+H1FqCo7obo6
 xiCb9sBUhwCZq0/lTnzxPwniGfMKvfLOATjhLdhQjls+SVRunUE25KeDvdfa5PLp0Slz
 xbmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbqo+7jNUGWYkxTZ9clnAw4JBd/r7tpmybQdFU6wiZMfCQRJkE/5DVNRGdW7enx2SGNVg=@dpdk.org
X-Gm-Message-State: AOJu0YyLnwg6T/mNaj145mo8ls8OjnOzLfL5TtK76d2Cpgic+ndPyM3F
 hC2e/2udUNL6cBEASZ+InvwuqWjp6qdUh4U3TCgDNOL9aGHYIKkhq/ScbjPdTrBPyld6Grt/h1/
 4od4C9DyrWxyQ2r6NZCZGPZZXaQQDZrim+TIgZ5hmQ7eHLnyEEfKNpa2+TwhCuQ/oxRRybbDnzV
 ENX8AAeTvQbPZDC1c=
X-Gm-Gg: ASbGncuiL3+ZQvdTkRPFUTIxo2VgLyAT8OFJWUWBXA0rABncbewwp6GvaTiTapbviWu
 5Q38mRu29xVlJhW4f0OY9xX5Z/60qpIoXeNR4scZ6VPzry0RXVq/unEu7Q/cp1Cc5613lbAU=
X-Received: by 2002:a05:6512:39cb:b0:54e:86f3:5e4d with SMTP id
 2adb3069b0e04-54fa4f9be04mr3091054e87.38.1746537330532; 
 Tue, 06 May 2025 06:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwa2ccS6wTwpVlwv4anOkvAbHPD2NoFhOavymN2UtYcQpeUdXC5wSXD02/bWJyGdutTHz20KI65vhX07hPhug=
X-Received: by 2002:a05:6512:39cb:b0:54e:86f3:5e4d with SMTP id
 2adb3069b0e04-54fa4f9be04mr3091046e87.38.1746537330100; Tue, 06 May 2025
 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250410083720.07b762f5@hermes.local>
 <aA-wWTEaXLb9Fa9f@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aA-wWTEaXLb9Fa9f@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 6 May 2025 15:15:18 +0200
X-Gm-Features: ATxdqUGIWxsfsDogq5jtBtonqq4Kc6vWgD_dyhAZX9ZP66NcVC6V8tOZ9wH-8N4
Message-ID: <CAJFAV8xGadgphm5tjx=jb51sFjGuG7JNWJ94SKTtknoseH_tdw@mail.gmail.com>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T8Pabuu-3FWgmSwRn6YNe35RfDsl1Y6-MLs-n2S8w8w_1746537331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 28, 2025 at 6:44=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Apr 10, 2025 at 08:37:20AM -0700, Stephen Hemminger wrote:
> > On Mon, 31 Mar 2025 17:09:49 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > Many DPDK drivers use the same pattern for base code handling, having
> > > a meson.build file in the base code directory which optionally define=
s
> > > some custom cflags for the base code build, then builds the code as a
> > > static library and extracts the objects from it. (The reason behind t=
his
> > > is that, in meson, cflags apply per-object, so we need to have a
> > > separate build object for the base code to use custom flags)
> > >
> > > This patchset deduplicates this logic by putting it into the
> > > drivers/meson.build file, and allowing individual drivers to then jus=
t
> > > specify values for "base_sources" and "base_cflags".
> > >
> > > Depends-on: Series-34946 ("net/intel: clean up base code build")
> > >
> > > Bruce Richardson (10):
> > >   build: add generic support for base code in drivers
> > >   common/sfc_efx: use common base code build handling
> > >   net/hinic: use common base code build handling
> > >   net/intel: use common base code build handling
> > >   net/ngbe: use common base code build handling
> > >   net/octeontx: use common base code build handling
> > >   net/qede: use common base code build handling
> > >   net/thunderx: use common base code build handling
> > >   net/txgbe: use common base code build handling
> > >   raw/ifpga: use common base code build handling
> > >
> > >  drivers/common/sfc_efx/base/meson.build | 18 +++---------------
> > >  drivers/common/sfc_efx/meson.build      |  3 ---
> > >  drivers/meson.build                     | 20 ++++++++++++++++++++
> > >  drivers/net/hinic/base/meson.build      | 16 +++++-----------
> > >  drivers/net/hinic/meson.build           |  1 -
> > >  drivers/net/intel/e1000/meson.build     |  3 ---
> > >  drivers/net/intel/fm10k/meson.build     |  3 ---
> > >  drivers/net/intel/i40e/meson.build      |  2 --
> > >  drivers/net/intel/iavf/meson.build      |  1 -
> > >  drivers/net/intel/ice/base/meson.build  | 22 +++++++---------------
> > >  drivers/net/intel/ice/meson.build       |  2 --
> > >  drivers/net/intel/idpf/meson.build      |  1 -
> > >  drivers/net/intel/ixgbe/meson.build     |  3 ---
> > >  drivers/net/ngbe/base/meson.build       | 12 ++----------
> > >  drivers/net/ngbe/meson.build            |  3 ---
> > >  drivers/net/octeontx/base/meson.build   | 19 +------------------
> > >  drivers/net/octeontx/meson.build        |  3 ---
> > >  drivers/net/qede/base/meson.build       | 17 +++++------------
> > >  drivers/net/qede/meson.build            |  1 -
> > >  drivers/net/thunderx/base/meson.build   | 10 +---------
> > >  drivers/net/thunderx/meson.build        |  3 ---
> > >  drivers/net/txgbe/base/meson.build      | 18 ++----------------
> > >  drivers/net/txgbe/meson.build           |  3 ---
> > >  drivers/raw/ifpga/base/meson.build      | 21 ++-------------------
> > >  drivers/raw/ifpga/meson.build           | 15 ++++++++++++---
> > >  25 files changed, 60 insertions(+), 160 deletions(-)
> >
> >
> > Looks ok to me. Since depends on the Intel part, lets take this through=
 next-intel tree.
> >
> > Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>
> While I can take this in next-intel, the required changes from the Intel
> side are already present in main, so this should be ok to take through
> either the net tree or, better, the main tree (since it's not just net
> drivers it affects).
>
> Thomas, David, do you want to take this (well, the v2) through main tree?

Sorry, I was looking at v2, but I replied on the v1 thread.
In any case, yes, I merged it to main.


--=20
David Marchand

