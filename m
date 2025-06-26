Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEAEC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:14:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE39D40287;
	Thu, 26 Jun 2025 16:14:52 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 082B940156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:14:52 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d41cd4114aso168317285a.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750947291; x=1751552091; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PChGmXiRvE/fVLiBo/RS5Oz1t1TfwlOcZA22Z9tvDnA=;
 b=H7yv7bT5za7ke0EliUkMn2EkHqv258s6SxaLg1P1gU7MH6JVP4fJWfNusoKWSN1lA1
 JhU8UzVfx0EFT0d9ldQOD9/mZlwByUbdQrpBRDpbNwFFtzYED+9IA6+a91h09O4NlmPc
 d989HBPXaQoEqCr08R/E3/kTah0UEIYOUEotxuzELCizI8g/zaL6d++Cl+x1BR0e1oRT
 ye0ZGh0qLYjCuw38H/vqij3iHPLEavBnfezv/+ounYsjs1xYIqe5ZESrpcwD8z/eAppM
 0l5MIGzAIpfgjAMacfYnl8K8cWoPUTf882Gu2iQkH2JukjP5CzkfLqqGHUVkQUOi4Zmr
 9EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750947291; x=1751552091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PChGmXiRvE/fVLiBo/RS5Oz1t1TfwlOcZA22Z9tvDnA=;
 b=Sf4BHLPU4Amwd5/DLrBtNgfBLDfWDCDXxa4ZUPM7xYKJiSmdj5+MlEHuuAEOOZzx25
 Qdg6FhRiaEEBXL4XOgB6akcELzc/jj1/HeYZmn0a8P2WtdmoCpnfQspbP4gX1hrdB8jL
 5I/r3HFgiLzDippJLrDFy+YFTRljOkQNHTLEJ1ilc4UJO3/ZFTj4qGY3qVrPyD0CAC92
 i0KnPOJB54BWvgmsWwGA12E8DDIJZz/BMnvL+AZjqV4OQ2fQCgoEN/4qLZOWlW0RAxKD
 6MdY9NGBo+RM2CVBTSv4ZXvmIJ916xrmtfuP5oBxs6e5S1EuommMoML4BhIPNs64N4y4
 ssmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc2FkmLlJJ50PDP4xWahzCFop+JWW3sGGTmEadThEcMbENhgCJTlODzK+RU8lTUwb3hPM=@dpdk.org
X-Gm-Message-State: AOJu0YxZTG+FwQms1XfggMCFFcZSNbeEiTGBxSqk/wNJ0MMQBrGRikJn
 5Uo2N6ITmM3P82nTtq3fS21JL9zOL7MdYwUOKxeUXclUFoS1xu6PBZnr7sIEZWuNyFuwKFIJ23X
 vy7w8Qs+Jkxp8I3X9xZuB9ySU8s0C59Y=
X-Gm-Gg: ASbGncuWcauPNEmaT7627QCzQX7BjILVusTiowTS8f6wJVNTgJpPL2Q7ntA2zrGbiW5
 n3TlHLwcsMHDUBc9PkY8lC/XYzPyOdLygljhNlP+/T6bjJDiYSlZ1KLNVqpGvZwcx56u4+cvi1L
 zIQ4yZfpeAMFrKAoT75JFbT3dAhqviRrx2veo5TBnFS+i9
X-Google-Smtp-Source: AGHT+IG792qotuY2LrLvbxoWF4jFMdsUQ125jk4YzEvPGe0s6Fyq3fseWsqbWTDXuwi2/FD5/1iG6lOPdfFN3plysz8=
X-Received: by 2002:a05:620a:470b:b0:7c7:a524:9fe9 with SMTP id
 af79cd13be357-7d429755413mr1075969785a.27.1750947291088; Thu, 26 Jun 2025
 07:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250619154501.3869031-1-nsaxena@marvell.com>
 <20250619154501.3869031-2-nsaxena@marvell.com>
 <20250626065901.55d0dcbd@hermes.local>
In-Reply-To: <20250626065901.55d0dcbd@hermes.local>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Thu, 26 Jun 2025 19:44:40 +0530
X-Gm-Features: Ac12FXzHaSytuEDdLPm3VRRJwYdGKVDl7Us2M7afh9VZNkyW7Q5M-i25fg3fuDc
Message-ID: <CAG6-93znfSj8EP8-2TdyWGCBBEskPdd7Rx2y5+Rq87PAXL96=g@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] node: add global node mbuf dynfield
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nitin Saxena <nsaxena@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, 
 Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>
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

Hi Stephen,


On Thu, Jun 26, 2025 at 7:29=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 19 Jun 2025 21:14:49 +0530
> Nitin Saxena <nsaxena@marvell.com> wrote:
>
> > +#ifndef RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE
> > +/** Size of persistent mbuf fields */
> > +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> > +#endif /* RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE */
> > +
> > +#ifndef RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE
> > +/** Size of overloadable mbuf fields */
> > +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> > +#endif /* RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE */
> > +
> > +/** Size of node mbuf dynamic field */
> > +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> > +     (RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE + RTE_NODE_MBUF_OVERLOADABL=
E_FIELDS_SIZE)
> > +
> > +/**
> > + * Node mbuf overloadable data.
> > + *
> > + * Out-of-tree nodes can repurpose overloadable fields via
> > + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are no=
t
> > + * preserved and typically can be used with-in two adjacent nodes in t=
he graph.
> > + */
> > +typedef struct rte_node_mbuf_overload_fields {
> > +     union {
> > +             uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> > +     };
> > +} rte_node_mbuf_overload_fields_t;
>
> Having a blank scratchpad rather than a real defined structure means you
> lose any type checking or potential overflow checking.

Patchset-1 creates a blank scratchpad but patchset-2 adds following
fields when added field is used in ip4/ip6 nodes
So idea is to add relevant structures as and when they are used

 diff --git a/lib/node/rte_node_mbuf_dynfield.h
b/lib/node/rte_node_mbuf_dynfield.h
 index 1069c07d44..045c13e352 100644
 --- a/lib/node/rte_node_mbuf_dynfield.h
 +++ b/lib/node/rte_node_mbuf_dynfield.h
 @@ -46,6 +46,15 @@ extern "C" {
   */
  typedef struct rte_node_mbuf_overload_fields {
  >------union {
+>------>-------/* Following fields used by ip[4|6]-lookup ->
ip[4|6]-rewrite nodes */
+>------>-------union {
+>------>------->-------struct {
+>------>------->------->-------uint16_t nh;
+>------>------->------->-------uint16_t ttl;
+>------>------->------->-------uint32_t cksum;
+>------>------->-------};
+>------>------->-------uint64_t u;
+>------>-------};
>------>-------uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
>------};
} rte_node_mbuf_overload_fields_t;
