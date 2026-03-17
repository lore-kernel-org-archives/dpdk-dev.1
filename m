Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3AFED9E8
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5986340609;
	Tue, 17 Mar 2026 17:26:46 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id AEB9540609;
 Tue, 17 Mar 2026 17:26:44 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CBE9E7A0123;
 Tue, 17 Mar 2026 12:26:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 12:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773764803;
 x=1773851203; bh=t6iHxkOCoVrRUOdgrnL6L4Bpkck0zzhMBzQ1k7FnaBg=; b=
 HSBxO2Zv3y/0zsuZO9kvSOSt+AAn7rRyWYG70LbFMEX+BKPzkbgZalTNKThGs1IX
 ZvnQegH/v+kZRNM0ZV97vH5moLOutCkeVipZ6lQi9Z2YH1YLgeBit3rtT5nDeObv
 rGZ9OYT6mn5Z2NtC2oKEFlxwUxZtxFTKry8e2l95RdOux46l6rQ8JHxQxTSNyEG4
 I4dn1uze94WjmO2Z+GfZp4JRSAE9RvFKoG/9Nv9SR1swsc0cdMNBeArfT5VL7BQD
 kBZZLCSFTSiRxFQD9gH36UpjdoLslwtF9ts+OWyIkXN14k2srPzOf44VZaclWipy
 jfobXCXZNCWBs6bRRnlYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773764803; x=
 1773851203; bh=t6iHxkOCoVrRUOdgrnL6L4Bpkck0zzhMBzQ1k7FnaBg=; b=2
 rQBi9JW7qC7uIeoiyR6JOJpj4IAqbE6/chMcBr+SbebbsDPndNnqvmaCZz6odK4t
 cuw4L0Lm+rc1TgopJkISJ6+jOhWgte6QqoV5Pa0vWSrDfsdzznzW5iV9TrN/N1d8
 iqVt8Os35HGKEzDtweke0EtatOG46dXKybygj59f8N4qsbqRC+H5jTjsRGeOoX10
 5c+j1l/qaMDGKpcvFoYNPg/7DXetoF3XbXlg24m3RGuxdk3pZXIHUZBfLeYrQm0+
 d86zpoEgOF6U0wBLr+oDQn+nj9QvDbfTFewKpnuO+E8lWaZNZCYxhG81+4fizdav
 ucrqA2KbI/T2l1V1VdRyQ==
X-ME-Sender: <xms:w4C5aeg_YDlLhWcEZKrvLPPA1hlubBG_OV_H60Za8SvlyqvThyOPFg>
 <xme:w4C5aZ_EdZA50ABi6mdGiO7AfkvsZO9AIjfvOaqx8nJKCqupjn1Ku9ynaazM9V34U
 VM8YJf8miuuE1MwyrxjYEEu9qC0o6JnxGsGZf73tHDyyi0tawZDpg>
X-ME-Received: <xmr:w4C5aVEIaIMmR7rpsa0gszP0V7z0UbYxe0KTali6n0sJlBnvxDcONbNIQ8EJUuDjCUovfiHelmlJHKB8Ac5IrEPK0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdho
 rhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiug
 drmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvges
 ughpughkrdhorhhgpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnth
 gvlhdrtghomhdprhgtphhtthhopehsihhvrghprhgrshgrugdrthhumhhmrghlrgesrghm
 ugdrtghomh
X-ME-Proxy: <xmx:w4C5aclUPlJesauE-U2_rd4BNDlwLh-elZSJR-mZJWHgBj_H_-j9Qg>
 <xmx:w4C5aZaLRmeyo_TG4bm3FVsKx5fzrsFChX1Tr3DR0Yn4rUN-wuzf8g>
 <xmx:w4C5aRGhaauFN72r2_SteH9_d-tqO7kI1YQCrf4YAxC71DfC_4IqCA>
 <xmx:w4C5aaKuD2R1GxR2NosQqq-kkf_LKceS-RyW5YKodvW943nINTaYrg>
 <xmx:w4C5aSzRXd5pVqg3HGhQ9rk4LIScpnrMjlmotUD_-rvEGS3y8QILDNnM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:26:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 david.marchand@redhat.com, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples/vm_power: fix format-truncation warning
Date: Tue, 17 Mar 2026 17:26:40 +0100
Message-ID: <2781936.q0ZmV6gNhb@thomas>
In-Reply-To: <aa40bb29-8585-4f15-8909-2086b0fd0b08@redhat.com>
References: <20260225173632.283928-1-ktraynor@redhat.com>
 <20260225103251.37c715f4@phoenix.local>
 <aa40bb29-8585-4f15-8909-2086b0fd0b08@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

26/02/2026 11:48, Kevin Traynor:
> On 25/02/2026 18:32, Stephen Hemminger wrote:
> > On Wed, 25 Feb 2026 17:36:32 +0000
> > Kevin Traynor <ktraynor@redhat.com> wrote:
> >=20
> >> Without libbsd-devel strlcpy is defined as rte_strlcpy and a warning is
> >> raised for format-truncation. Observed with gcc 15.2.1.
> >>
> >> In function =E2=80=98rte_strlcpy=E2=80=99,
> >>     inlined from =E2=80=98add_host_channels=E2=80=99 at
> >> ../examples/vm_power_manager/channel_manager.c:600:3:
> >> ../lib/eal/include/rte_string_fns.h:63:24:
> >> warning: =E2=80=98%s=E2=80=99 directive output may be truncated writin=
g up to
> >> 4095 bytes into a region of size 108 [-Wformat-truncation=3D]
> >> 63 |         return (size_t)snprintf(dst, size, "%s", src);
> >>    |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> Check for truncation of socket_path[4096] into channel_path[108] to
> >> remove warning.
> >>
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> >=20
> > Since socket_path is a unix domain socket path.
> > It should be UNIX_PATH_MAX (108) not PATH_MAX (4096)
> >=20
>=20
> Yeah, I had adjusted all the socket_path/names in the file to
> UNIX_PATH_MAX as an initial fix but it spewed a different truncation
> warning as one of them gets a copy from dirent->d_name which is 256.
>=20
> So considering it's just an optimization of example code and hasn't
> really been developed over the last few years, I just fixed the warning
> that showed up.

Yes I suspect this example to have many other problems.
The whole example should be reconsidered.

Applied, thanks.



