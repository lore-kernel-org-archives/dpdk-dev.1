Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907FFC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A1554021F;
	Thu, 26 Jun 2025 17:13:53 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id B7E4F40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:13:51 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 35F29EC0077;
 Thu, 26 Jun 2025 11:13:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 11:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750950831;
 x=1751037231; bh=xIcF7AsC/cPgfJStbwWDfGNUc8wvvDdcvC1+HrnSwgU=; b=
 d3ZdoOXWkeDc7GIfjbjYgf0i7NU7Yb01F79YfBx164HMEi+viS9qDn1RI7CDHflL
 ihKtF4TeQ/b1C120BviJUxOPLVC5sGiP5EmnCV+PtePQO1gD0kyFAY1r17yjhvok
 CHXY9mzrbT+ZCzzOCK+nuMJfKWHkhsfx1PDXZd7cLj4auYXyXR0ImQyBmw8Hwfn9
 1n44QoEncjnCfzpAC1vtZX0d6ja/ZfTCTrmfc4VX+rAjWKXKhm+eWcsTLv2FxV5Y
 iYht/RsywS9JpiC7ndhHJ+1N2p1ougHGuSW/JNFEqpfQXObdE4ch0p6MiReHpfSt
 2+2Cg2Z3zOVuCAfwMe3zBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750950831; x=
 1751037231; bh=xIcF7AsC/cPgfJStbwWDfGNUc8wvvDdcvC1+HrnSwgU=; b=F
 sG9X/bYLYd/2HPNH0peEKF/NmPbYmtdW0aYux9FAOmLFcT80Nmx3ZV37ewA0LLFS
 ha7ewQyG1ELg+dCRFBu/Tgm8hpmGzchugjAFiteWebqliwhKqiAk52ecT6DRyZ4r
 Rad4bB9NyKP3PzjvFG4OXClOe8tdwKG51jOOMyibwnGkX8bvfkINFmllUHarq+af
 D0dbnAVstVHLw099G84es2WYw8EgSFuaNswTAVDBS2wcnkHswrkpEIKiiBenyaIT
 VhMgDeY/rfL/yEzv+Sry7Mu5xrrNAjnXr2630d225STQkx2TAKHQ1OVW0Ld563MA
 48dbaO9KI1TG/phP1xqDQ==
X-ME-Sender: <xms:rmNdaMBj_q8IilIetBhjd7vHlVhlpdjHGjdNRgj3WqPDBCgGLDi_kw>
 <xme:rmNdaOgU5TnTTEuZHJeX24GahozdVNH_y2iUJL_a5bHBMAM_XPO5yv_bV2ioBkfJt
 hJRfp_sEifdg2SDvw>
X-ME-Received: <xmr:rmNdaPmukuT725D0FWH4rFbq_xQcz82GCRhmk-20gOU3C0wXui34AvjLqrIzfC2TtW3e72lqIgn2gVku_UShTW7pqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumh
 gsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 fhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrd
 hrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruh
X-ME-Proxy: <xmx:rmNdaCyiF5zxN_CT9w1vnFbwC-RfjNZqnWzImmfUdWpQ8AAb9d1M5Q>
 <xmx:rmNdaBRZl5bDy-ZKjQmVdvLriOZ2ffTed2e6Ck--lNijffzaz6VtcQ>
 <xmx:rmNdaNaBzw_Q9hcLFJAtVYutRi-C0vmUjmfHnjgMjtnGIOEI3gK1Wg>
 <xmx:rmNdaKQd5uHMfdDSYwCe-BAu1t2PeNPC1DRvCE0CcabVfRR_wX44bA>
 <xmx:r2NdaMlmfetFKwXzcl6BFkmflnZXOxDFo2W6vmsJJkg49YSOH5Gq-psh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 11:13:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: sync ethtool link modes with Linux 6.15
Date: Thu, 26 Jun 2025 17:13:47 +0200
Message-ID: <3888072.ucjEoNaZvj@thomas>
In-Reply-To: <20250626072651.79d51099@hermes.local>
References: <20250625134202.3193570-1-thomas@monjalon.net>
 <20250626072651.79d51099@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

26/06/2025 16:26, Stephen Hemminger:
> On Wed, 25 Jun 2025 15:42:02 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
> > index ec42d3054a..f508cdba6c 100644
> > --- a/lib/ethdev/ethdev_linux_ethtool.c
> > +++ b/lib/ethdev/ethdev_linux_ethtool.c
> > @@ -17,8 +17,9 @@
> >   *
> >   * The array below is built from bit definitions with this shell command:
> >   *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> > - *           '[\4] = \2, /\* \1\2\3 *\/;p' /usr/include/linux/ethtool.h |
> > - *   awk '/_Half_/{$3=$3+1","}1'
> > + *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> > + *   awk '/_Half_/{$2=$2+1}1' |
> > + *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> >   */
> 
> The commands in the comment never worked verbatim.

It works on my machine.

> $  sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
>            '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
>    awk '/_Half_/{$2=$2+1}1' |
>    awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> 
> > > > sed: -e expression #1, char 63: unterminated `s' command
> awk: cmd. line:1: warning: escape sequence `\*' treated as plain `*'
> awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/'

The backslashes were added to help the syntax highlighting.
But I can remove them.


> Fixing the comment would be:
> $ git diff
> diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
> index f508cdba6c..8a148ae0cd 100644
> --- a/lib/ethdev/ethdev_linux_ethtool.c
> +++ b/lib/ethdev/ethdev_linux_ethtool.c
> @@ -16,10 +16,11 @@
>   * and allows to compile with new bits included even on an old kernel.
>   *
>   * The array below is built from bit definitions with this shell command:
> - *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> - *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> - *   awk '/_Half_/{$2=$2+1}1' |
> - *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
> + * sed -rn \
> + *   's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;[\4] \2 \1\2\3;p' \
> + *   /usr/include/linux/ethtool.h | \
> + * awk '/_Half_/{$2=$2+1}1' | \
> + * awk '{printf "\t%5s = %7s, /* %s */\n", $1, $2, $3}'



