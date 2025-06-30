Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949CC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 14:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8A5402A5;
	Mon, 30 Jun 2025 16:54:39 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4DEB040291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 16:54:38 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a818fdab84so19932051cf.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751295277;
 x=1751900077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emTMc93eU7ix+JTViSBgQ1RsbEcQc/tdL++G0n4hhus=;
 b=p3i+l+WV5zV1MviR0X9N3jQa9U1PQnxIrkblgNT+dQeV/o57rRHci3TYep3BwVGK0c
 Cu835UFU9U9hYyvY8Pvskt92lpPJzMliiR6nYkuTtwXjpKuFNsRj3dCjlye1cGJGzgh0
 tyYZUZRq7NwG6eyqD0GN0LfMybBu+CeeKeumhiUHIl25d+jM1Ks/pdZ6cETiVBwZZHlw
 C8u29Y8g9DvN84LHhe9H9qqzxZgdG71DnYYJQbM0Prld5EWhCR9av7PzefUG+8UTFVqG
 ia7UjIbhbJXRQGt5HlOPp7ZyKBINTzqHMH//gJcX9ivKBpvJc3uDVbqOA5iyYkC3MYVG
 KNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751295277; x=1751900077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emTMc93eU7ix+JTViSBgQ1RsbEcQc/tdL++G0n4hhus=;
 b=LuSNlUeXn8lUdHH3HuqcnTw4ZGBNDLbsHcemiJGla/GiXCgsV/U0NQwa9FFe/XmK/d
 1xoP/MkdrgCG0KldDImy7+Mtgo2aSXan+a+Ppfy0kLNaI1lej38fCxDpgO39x/rENSD3
 97yyfcgJ67mLz0wLygdlcQmn3W+8NcJaobwHUw0uET40e1CyhSltkVGG1euoHsPX6ufo
 xAYWCMcpAcTgVTcHq+5MkGpZBrseeWssNQnqIrZBgLXUkZegP/jgpyhwmeUi5zVGFBbe
 uLDT5qflULQdsNWDVVeOJqlWQtMacoio3IeRmCpYhd+k4UzBpXLnN08TyNiBf88S++W0
 30FA==
X-Gm-Message-State: AOJu0YzWm+DdNoIyghuusFxZdE4qkWRvcgp8ALvX8ItZ1k2EyqxAAlJo
 FQZdyDUajwVATv4kq5qg46rHTzjgMYRCBh88LoyBIp9MJqbu0alCHW0eAmLd4qRCzVU=
X-Gm-Gg: ASbGncv8UPl8CjsuVZCECqL9ZuZlHdqwohnn9YSlffbsJk++ijYm7pVm14/2HMeJetm
 0bnm2KHCHml8INxnsjBRDUmkI51NrAMF3pmtsK3FP++p+7zqicF+QGZdbDwCJc3gJetRnOFNs0N
 E43WXiXAISzvMjDmvjr0c7zPpDZge22sGnslDzf8oL3GIBZvxYQoCIqgrf5+Ct7xReXi/aBT2z3
 oAoJ5DqkoEp7JS3pUWIDfsw41+aFrjMl6H3AxEod4iKpbmResX7GlxsMdi/NjjebWzBxxUZ3xDU
 qS+MkOurZVld2R/GGNdFCMBXDFRd7wbr3zkKSkaIccJlzQtCG/kxD+ZWYmpLFfNvtoNHc+uLSaA
 O8msNP3L1mAZAPnHovDgCr+ENqqUJTIGswwum0Cg=
X-Google-Smtp-Source: AGHT+IFNscw0m7A7PCVq+F0m/DFW1O93bLeD5PdEFdGjebCd+3TGZ/aQTZ4QK+ijbkT9TRkujWa4yQ==
X-Received: by 2002:a05:622a:1a13:b0:4a7:fa7a:384a with SMTP id
 d75a77b69052e-4a8066df9f5mr184434301cf.41.1751295277563; 
 Mon, 30 Jun 2025 07:54:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc5cd906sm59685301cf.79.2025.06.30.07.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 07:54:37 -0700 (PDT)
Date: Mon, 30 Jun 2025 07:54:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Brandes, Shai" <shaibran@amazon.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v4 0/7] net/ena: release 2.13.0
Message-ID: <20250630075434.02a990e6@hermes.local>
In-Reply-To: <6be9d6041a3e4cdea8ed6609c32f9b38@amazon.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
 <20250629094931.05268741@hermes.local>
 <6be9d6041a3e4cdea8ed6609c32f9b38@amazon.com>
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

On Mon, 30 Jun 2025 11:08:12 +0000
"Brandes, Shai" <shaibran@amazon.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Sunday, June 29, 2025 7:50 PM
> > To: Brandes, Shai <shaibran@amazon.com>
> > Cc: dev@dpdk.org
> > Subject: RE: [EXTERNAL] [PATCH v4 0/7] net/ena: release 2.13.0
> > 
> > CAUTION: This email originated from outside of the organization. Do not click
> > links or open attachments unless you can confirm the sender and know the
> > content is safe.
> > 
> > 
> > 
> > On Wed, 28 May 2025 13:25:24 +0300
> > Shai Brandes <shaibran@amazon.com> wrote:
> >   
> > > This patchset includes an upgrade of the ENA HAL, introduces a new
> > > feature, and addresses three bug fixes.
> > >
> > > Thank you in advance to the net maintainers and community members for
> > > your time and effort reviewing the code.
> > >
> > > Best regards,
> > > Shai Brandes
> > > AWS Elastic Network Adapter team  
> > 
> > Could you check against current main branch.
> > This no longer applies, either it already got merged or something changed.  
> Hi Stephen, the merge conflict occurred due to updates in the release notes after we initially uploaded the patchset.
> I've rebased the changes on top of origin/main and will submit a revised version shortly. I'll go ahead and abandon the previous set.
> 
> Just a quick note, we originally submitted the patchset over a month ago, and it has been in the "awaiting upstream" state since then.
> I noticed that rc2 has already been released.
> we would greatly appreciate it if you could include the ENA changes in rc3.
> ENA is a self-contained module, and the previous maintainer approved that mode of operation. Hopefully, an exception can be made in this case.
> Thanks again for your time and continued support. 

Thanks, that version got lost in the huge patchsets that were sitting in backlog.
