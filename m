Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C74CC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E77941156;
	Tue, 17 Jun 2025 17:49:59 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1398D402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:49:58 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a43afb04a7so44196931cf.0
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750175397; x=1750780197; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hWoyWO3447dfCyMO4EimMGr2bSI1h/kbtPsxRvWp/A=;
 b=a55e4ANK1+0eXhexwdVef/PMq+zGjVL5izqHMrxsXahh6IGSCuCTn1dexN9PrjqdyU
 NK5HOnHG+419Cf0ecgZhEIt0UMIgw3iq7XLt4Dw32a5vJrXz7zFSXLO2nQcr1FyFSFCU
 8nfwI3z5g1okm+ZqlhvAsbpKrsLy3wVAJ0JnToHLrKlIzPxPhSL3XThB+/BseCi98Mdc
 onY7Bs30kacHpfnw4jQ6Tg1v61t5G9oFLpxLG8bXYMsy3dn4w3oDNdrCkGbz+TZz7oOX
 T+jieJNZ9zsEsYa5XS2xeKKd7NZCkkthjpq1nrLGq2L/LCJMCqfGpxZ0gyqqmxzf3KpT
 Q+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750175397; x=1750780197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hWoyWO3447dfCyMO4EimMGr2bSI1h/kbtPsxRvWp/A=;
 b=Y1msJyiZLbiOLjEqEtW2QlVfw9YjNR7Yg5ek2ziTRnTjpV7L3KAFMu55UAJ/STwqdU
 4GzSPoaK0sIheXK4ayNZrxnkWbiYAZcfjaMcy8KjpvcQYPXrLOhsV173ItuQVQOQdZgZ
 XgiokH93moH+EVaibzBuVl11RAyGB0xv2kQkwCHAXWnUiNOwaoS4job8DslOHaOQCy6V
 XHujjlMCUgPdXQuWvD8JDp9ZNKQy6+uqKr/FXIsH3kVkP6KbxOeQ1rSLW9RnlOfbekMu
 OXAons2hMbeBfgzy7sh+nB1561pdV77NEThV38gu5qBtHImxh9i2GmeZS+bWR07mKq9t
 v04Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSe2PiHkzA3of8rxFIl6Pyjz+ECPOpDYV452ec2a7TjGFg6eXAKKVqYrPXFtS2OBRB6Zs=@dpdk.org
X-Gm-Message-State: AOJu0YxZj+uk2ARBufoQaDldddIbixJDDY4WPTcq4de7LiPVX6MKBRcL
 oVNIIfv3boGCOiMboOCwPo8yektnkdT0OOu8ZbOHc+EnOyLQQsjGpfdSegaUJRnDWwVMvY100xT
 uAmtfkJjYwf/dR/aHpK4UN5qkkklhU2Q=
X-Gm-Gg: ASbGncs9y+TeobuKuchbSYF5rPA4iyYYEoRiGlkFpXgWRCGPd2Z9e6eVLEQ1YI4PJZN
 42RAiSHzHCUeJ630PpSmgt9Ff7QuneeZo5gGCWm2EzRU9vjQCgXeyizmy33jJ8dlasVIs8rs1EX
 1sw39dSlw/UEYZ+mJtkKVHsN+gC3aVUinqU+jo27Zw90jGC+1i90+j
X-Google-Smtp-Source: AGHT+IFpLe7QLS3bAqudyBx0mXwoZ4/Y2QISbrEcJs4qhIIRJUJLD0klDjWdp/UXepCytdK3vN9c9Hq3aCkbvpobeyc=
X-Received: by 2002:ac8:754b:0:b0:476:8d3d:adb6 with SMTP id
 d75a77b69052e-4a744b41363mr143901681cf.23.1750175397218; Tue, 17 Jun 2025
 08:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
 <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
 <df33e20237384492bd1fafbdd2e71c56@huawei.com>
In-Reply-To: <df33e20237384492bd1fafbdd2e71c56@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Jun 2025 21:19:31 +0530
X-Gm-Features: AX0GCFshkfYoxSNcaxIBRcswCJiIS5eHAT97VOGMofqDBpfd9urSGpfNjpFEcO4
Message-ID: <CALBAE1Mggs++Wi34uxFU_hp8fOhn9=Nfuy+dAOTU83JucsWTdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
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

On Tue, Jun 17, 2025 at 9:11=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> > -----Original Message-----
> > From: Jerin Jacob <jerinjacobk@gmail.com>
> > Sent: Tuesday 17 June 2025 16:28
> >
> > > -struct __rte_cache_aligned rte_graph_cluster_node_stats {
> > > +struct rte_graph_cluster_node_stats {
> >
> > This is a fastpath structure. No need to change the alignment here.
>
> rte_graph_cluster_stats includes it, so unfortunately would stay cache-al=
igned regardless of the attributes unless we make rte_graph_cluster_node_st=
ats default-aligned as well. If you are sure that we need to keep node one =
cache-aligned we can return to rte_malloc solution (or posix_memalign, but =
I would prefer not to hand-code aligned realloc).

I think, existing following code will take care of this. Are you
seeing the sanitizer issue if the change is only updating
rte_graph_cluster_stats alignment?


        /* For a given cluster, max nodes will be the max number of graphs =
*/
        cluster_node_size +=3D cluster->nb_graphs * sizeof(struct rte_node =
*);
        cluster_node_size =3D RTE_ALIGN(cluster_node_size, RTE_CACHE_LINE_S=
IZE);

>
