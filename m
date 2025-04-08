Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A772C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 07:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 367B040A89;
	Tue,  8 Apr 2025 09:35:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 01BB44027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 09:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744097757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtWZR6dI6gZBY0U+phYBRED1+k8mZv72pbWZwUhOLxo=;
 b=DsrSLtqrSaXSvcWks7/uzMAV1STD3KKHGsF9QKmKpI5ZKIdX5inYCIGRjYaotZMzrl967s
 3a7lyj2IvszzOQRWrEOMkkf2mFx3TJWKFbL8WwG3EQod9qWaXmXWlnr43ZcwOibYHTJ1Hh
 LjTTB9RfO5zkD0OPBa6hJbCVZmTFrsg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-ficLTgrYP0C3qjohJWkKOg-1; Tue, 08 Apr 2025 03:35:54 -0400
X-MC-Unique: ficLTgrYP0C3qjohJWkKOg-1
X-Mimecast-MFC-AGG-ID: ficLTgrYP0C3qjohJWkKOg_1744097753
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5498879a3aeso2173861e87.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 00:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744097752; x=1744702552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtWZR6dI6gZBY0U+phYBRED1+k8mZv72pbWZwUhOLxo=;
 b=NFgL3XYrsccsu0Kx6os9PAldLn6+aLxX2HpaAJ34wkJbpU3Nu+Ir1SxBOx4gPIDG2Y
 HbhxwBF2nKFm659jwiR6tIeG6bEKytFIQL+U28jhNI7vEnZhQf9ZgN9CtalsF3FnJ5Ji
 ahUuE/HdqTXDtwbeUKeObYHFIeRL3+MtdubbfsdJint5QLMdf3Q5MsLklGkdxjLVRNNz
 i1vavLSfnbQ/8IMl6sH7LJpeQZETmLtuWrkPuDwC38uEbiNMR0tvwYKmcTNFnAqxNQvf
 Vo6usxULCfp9tJNPZtBoLGd99v45YyWMeWzaTwrUpHWIZvk5SLsYsWdkDKSab4P1Tgot
 DbyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKWEt20AsbXwQsKAiU7llbGjN83CGJ2VWQgi0ANxijLdlPTpIPIf9eZu4KdGlciQpKO1s=@dpdk.org
X-Gm-Message-State: AOJu0YxTUIPixbrgaNt5BvHxsoVE9a4QRstcIhzPP1v/N2zskJUbxwMb
 30FoAmUsgIIORwbr/JiP4Ry2vey9wQ+jFGM8O7RmEMr5bNmP2X/M4ni2OyAGHFNa/IgkYwuZ2Ky
 27pfZZq4CmmjBFkza6Ir2+CiwJcjiUBEubjRPZ03DgiODDOAkGhOKjbsimYO12yg3RdLDG+1Jsb
 y70kSQnQurdod+GzA=
X-Gm-Gg: ASbGncshvkx4bnCU5X3uREb9kBF2XWzWJsZfqzwaDTVqjVaPANA/BqaoJ3hLhH2pZ0I
 zZMt0bSvbhEv0NVhNfQ4fibgL4rRze0X8S2y4pyvVOf61lB8y5Jekcc51Wpe6k8S3c90edo3wPx
 M=
X-Received: by 2002:a05:6512:401f:b0:545:2d4d:36de with SMTP id
 2adb3069b0e04-54c232f9ae4mr4718231e87.31.1744097752470; 
 Tue, 08 Apr 2025 00:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAIkg7ZUTWtWokCXs4mMJUWi6YrRuYegK/bdrVPu3xz1STGGjyU/RUKiAmCTOjyxtUXsr9hXuMjDY9L8lNxlc=
X-Received: by 2002:a05:6512:401f:b0:545:2d4d:36de with SMTP id
 2adb3069b0e04-54c232f9ae4mr4718225e87.31.1744097752114; Tue, 08 Apr 2025
 00:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250407074800.1651203-1-nsaxena@marvell.com>
In-Reply-To: <20250407074800.1651203-1-nsaxena@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Apr 2025 09:35:40 +0200
X-Gm-Features: ATxdqUHXCAiHYqh4lhivZYwfvw4WKfu1NRKxjx7FE2AiOvQp3dKWvV0I1JOIDIM
Message-ID: <CAJFAV8wW5GFzGHJpSM4dcfys54=PD+RfWCr7AsbUqZqf0RZhQg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] node: add mbuf dynamic field for nodes
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, 
 Jerin Jacob <jerinj@marvell.com>, Nitin Saxena <nsaxena16@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NxILXry9EkHTniKfJwR1UgKA9RAfgqSkHRZpyZsnHoY_1744097753
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

Hello Nitin,

On Mon, Apr 7, 2025 at 9:48=E2=80=AFAM Nitin Saxena <nsaxena@marvell.com> w=
rote:
>
> Currently each rte_node registers separate mbuf dynamic fields for their
> own purpose. This leads to wastage of mbuf space as once mbuf get passed
> a particular node, the registered dynamic field(by that node) is no
> longer used.
>
> This patch series adds a global/common mbuf dynamic field which is
> reusable by all the nodes(including out-of-tree nodes). This helps to
> repurpose same mbuf dynamic field for other nodes. It contains two types
> of fields: (a) persistent (b) overloadable.
>
> While persistent fields are those which does not often changes during a
> graph walk such as rx/tx interface, buffer flags etc. Currently there
> are no persistent fields added but they can be added later
>
> Overloadable fields are those which can be overloaded by two adjacent
> nodes. Overloadable fields can be repurposed by other two adjacent nodes.
>
> This patch series also updates ip4/ip6 lookup/rewrite nodes to use
> overlaodable mbuf dynamic fields.
>
> Changes in v4
> - Fix github CI
>
> Changes in v3:
> - Fix CI build error
>
> Changes in v2:
> - removed usage of memzone for saving mbuf dynfield [Stephen]
> - fixed checkpatch issues
> - redefine RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE to 8 byte which are
>   currently in use. Size can increase later based on the usage
>
>
> Nitin Saxena (2):
>   node: add global node mbuf dynfield
>   node: use node mbuf dynfield in ip4 nodes
>
>  doc/api/doxy-api-index.md              |   3 +-
>  doc/guides/rel_notes/release_25_07.rst |   6 ++
>  lib/node/ip4_lookup.c                  |  14 +--
>  lib/node/ip4_rewrite.c                 |  15 ++-
>  lib/node/ip6_lookup.c                  |  15 ++-
>  lib/node/ip6_rewrite.c                 |  14 +--
>  lib/node/meson.build                   |   2 +
>  lib/node/node_mbuf_dynfield.c          |  44 ++++++++
>  lib/node/node_private.h                |  40 +------
>  lib/node/rte_node_mbuf_dynfield.h      | 141 +++++++++++++++++++++++++
>  lib/node/version.map                   |   3 +

I did not review this series but I noticed some version.map update.

When pulling main, you'll notice that exporting symbols must be done
via RTE_EXPORT_*SYMBOL macros now.
No version.map touching anymore, those files are generated at build
time, so developers don't need to care about them.

In lib/node/node_mbuf_dynfield.c, you need to include eal_export.h and add:

+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register, 25.07)
+int rte_node_mbuf_dynfield_register(void)
+{
...


--=20
David Marchand

