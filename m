Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B9CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 09:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1870402DE;
	Mon, 15 Sep 2025 11:00:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3E45D40262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757926798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zeQ5skocLschJfFN0/9n1Dd5w8w11sKlyoX4jzZvK+A=;
 b=Oc9fSmYTrnKp4v+VsAlj+VAaN2xOEOwA2H2pdkQz95MOO8YSXZp+vf7pI+/yVMRZETUiwO
 +V8iU/LUMf0cwhqBmmz4362vkVQ5H0dY++Zl82s187eCdkLOfMg8cSOOpmcA6cPAkt0Deh
 d2aM5jYyrJghvC02mq2E+TF6moXJjFI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-SPDQRi0TMTGTa3KKaqRa1A-1; Mon, 15 Sep 2025 04:59:57 -0400
X-MC-Unique: SPDQRi0TMTGTa3KKaqRa1A-1
X-Mimecast-MFC-AGG-ID: SPDQRi0TMTGTa3KKaqRa1A_1757926796
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-336e1c46feeso18185111fa.3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757926796; x=1758531596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zeQ5skocLschJfFN0/9n1Dd5w8w11sKlyoX4jzZvK+A=;
 b=OSN/HhtkU1r5ATFIb2FlocSZrs2p5tyKBRH7IacsAwXegUDr0bm70fCmqlrWmj4Q7M
 WwXzz9LXv4qaIkR/J/nJUA/fKhjBW+aB6sSJjMXDFm9uPos/7RHID1jH3YvCDGDHSlL9
 AgSHEeEkVLdbTwYFlbFYwSC9HwoZN6YoaGORGXMfmhPIbHA3EBJbesYMcWxmsHe2xdEF
 GPgvUDSBlnChbuaQ6C99s7lDeak4qMxt9MGQ0Kt73a7SimmTsTFfZzk9ufF2Z2hq3def
 /otLX4T7fCHfAAFOqpfnhFFuZTNiSMHJuMesb5iiBTrC3aSVLsBTGcXqh7i5GpCNgV8d
 fm2A==
X-Gm-Message-State: AOJu0YzXQZ5KUdUXKpQxKqHQB8x2Vpl61N8cA15gXL1Qo22WB/cMylN2
 upiopVu5/lvHMA1gfbltJyqH4F6n7s15CzhqPZZdAO1FC8ovv7VwVRepQU/q+IkVqVbexTjpMbR
 Hm0pnQ5RZ9UwZXY24814YgDNtnX4WxS/WJzVQIh7DQnI6pNl5nKhU39lzzJpjeepV62sBfd3P/q
 P3GU+Pkc/FyvIgF2u8P0U=
X-Gm-Gg: ASbGncvk0tB0exaD2oIKNKe+DvNaFIC0NEUSXiLVLV8gIhyEEd0KQU9Mp7o9/cHmrcC
 uw54Z/mV9Rj90dhQeHxLoIayhoU1hwDzlkunLUqdDg0+C9zI1ffP0nl1pq4tz92RC7ilgd3w59+
 qiVjO//QHALwXzq1TEE+rbxZg=
X-Received: by 2002:a05:651c:435c:20b0:32c:e5b4:a225 with SMTP id
 38308e7fff4ca-3513db55033mr29432611fa.28.1757926795763; 
 Mon, 15 Sep 2025 01:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRilvVHDlvXvVK+knVuFG1JK3k40Swq/BLECyy/lcBbEA8cbAdw16UaPWIDmKekO5v+ty23RP3fMzODe/yCKc=
X-Received: by 2002:a05:651c:435c:20b0:32c:e5b4:a225 with SMTP id
 38308e7fff4ca-3513db55033mr29432491fa.28.1757926795308; Mon, 15 Sep 2025
 01:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-11-ciara.loftus@intel.com>
 <CAJFAV8wu3jQh2WAY_aUdS-Y1xFMFFtYrGGh_hgbROmMaEpWcgQ@mail.gmail.com>
 <DM3PPF7D18F34A18F628B6488BAB7ADD7608E15A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF7D18F34A18F628B6488BAB7ADD7608E15A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 15 Sep 2025 10:59:43 +0200
X-Gm-Features: Ac12FXzhsoNB66heNm7sFvb7BW67t2hE0STcwsfpem7rSiheIubEgX7cNBnpFVA
Message-ID: <CAJFAV8xp1Bckbudei4JFAFAacFYi8wTd50TnWXT0BqFSOMixSg@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
To: "Loftus, Ciara" <ciara.loftus@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>,
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, dpdk stable <stable@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -dg86UI5IS5v8zwjsHZ2i0gCGsBo7bnjUJNP-47EYRM_1757926796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 15 Sept 2025 at 10:45, Loftus, Ciara <ciara.loftus@intel.com> wrote:
>
> >
> > On Mon, 18 Aug 2025 at 13:00, Ciara Loftus <ciara.loftus@intel.com> wrote:
> > >
> > > The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
> > > driver so remove the one erroneous use of it.
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > I just noticed this fix in main.
> > Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
> >
> > This looks like something worth fixing in LTS.
> > Was it intentional not marking it for backport?
>
> Apologies, it was not intentional not marking it for backport. I should have added that.

The fault is not yours.
Let's blame the reviewer instead ;-).


> Shall I submit a new patch to be backported or can this one be used?

It is ok.
Just, the scripts won't catch this fix, so let's ping people.
@LTS maintainers, fyi.


-- 
David Marchand

