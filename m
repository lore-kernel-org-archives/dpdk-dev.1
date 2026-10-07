Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25124CA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 20:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC0740268;
	Wed,  7 Oct 2026 22:21:35 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id CB72E40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 22:21:33 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 1C9811D0013A
 for <dev@dpdk.org>; Wed,  7 Oct 2026 16:21:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 16:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791404492;
 x=1791490892; bh=UHYMI2GSNodvh4v7jN3fLMJK36DPAshorx/UQ2Jt/7g=; b=
 SbS1jDNw+y7i5WD0bARjU7V+oKfr5axlNgJxeYzLhET9KX+OSxmWAQN45ujYDSIB
 GZtJ2shZlbsOC7ZVQf25aZuI+MUh5yH/iPB+NJ98DFowGnOro45LMKkrbkd+zW6h
 MX9YY7uu7Kh3IwtkhVG68dHV6yypBOvj9nXEeeO03mCGVIUoDKfzTwHSRsiNkkqe
 J8NlmmctEOFr+wi5V5XuDhG/Spb/nmQFG/0WoXS1Toh3OdhFDNoodEQ2aB5wS9rn
 OyGX7H8JZbMk2iE5ZZQUlVHNllIDX78URs3KoN2Mbg2tMIAb5P9TRXdvVVxrjems
 o4r/B0msY9/+szGt93J9nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791404492; x=
 1791490892; bh=UHYMI2GSNodvh4v7jN3fLMJK36DPAshorx/UQ2Jt/7g=; b=n
 lgWXTJdmCbWpRBshwbbPfNchTO1m8xyeiIp92mkpfe39z5nlDzgDaIOMdRV22r5O
 41XwbHP5iz0HcOYbknAvKxz6qoyv+ZZErVZUE0tO5KBIV/x4W3QdiIPp1PgzQZQx
 ZzNqpXOT5d1OzirSaRcffN4PAy1n5mvFZmddGABrdW0WQXGglTIGs1dEMBsp9f1H
 RI/sX/a0e8o2KcjHyW3gmqqk5bvDaAr8pjxj7n8xs8oK9rxgJXMdS2mwijrproam
 GNrHYzVIHnCwV7ezV0aRMBZJ2JmyQUKp4gIkNPBZHw9T7+8KAj7hcKYJagUssoWD
 a5w3kmySkHppqqvT/OmPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791404492; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:KDB+vmJlgRCZK6naJJSwyNkAAM0HtU9W04i2BCdbKgsMHsx
 hkVb+Qwfph3M4zx04Y8p2VjomWVqISJGMBeTQI86G1L37taGFjXLHBGP+VAgKInR
 HYXzpFvKmmM5l4rVRjK1Ybr+GtFdWLMLSKRdteY8CsQ1MNI5stusxvShtkX6amxE
 hkNb5l7u/EO797h39vzbVHbcO5UffyUCbtIHA6D0kVwpc6Z6cds14bBE3hZyx092
 QVn/HIzO/kDN3hYuiQjWir8DQWIdnot9PwpsE+o2MdiDjKcK4FJNCtXrjFoKIxlr
 Gc/OzgAZgkoDNZjTaJxKyre6SDF1Qr+rScpRUlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:+ifUv+wzvTZBNBPryUJMAwd/11dcyZuTQv1+w5UnYTU=:4GcBq+jacrFD08ICAQcolNEvX1nCCrgq7pm1fZWp5/M=;
X-ME-Sender: <xms:zKnGaqEuT89QMAhowgFRetIeeZuFTLRmq-V3yaKEhm255ksTumzlfA>
 <xme:zKnGavprn6DKQTVupfhxMkd5f62x7TANczlsxDJVsAoSuwFviPjG-vHXXcaIlv3Z3
 iWe55QrKJNN-5sTv1HjYWBIO_Lwtmde3FgR7827jkUPLZC7arA6hvM>
X-ME-Received: <xmr:zKnGajRI8NDWCRKW5mDwXzqS-3uMvzVF9eZWUHnUCimkoMBXyv5FzQWqtHbQGIaNjOYJyq8eNvGQ4lcxWo2LyIE>
X-ME-Proxy-Cause: dmFkZTGCElsprzVb70mBRNfjE1Ndvd+1cAsGqp8n4rB3C5QXXRYfq+ISZaBPT6u4nH5iqJ
 2/UBIBUmfhyu80xrQOxuY3h4pnAts+tpzZLkZxrxiiovdgYJuZSDOs9r3jI2CkVfhylINN
 NBVpiaBCIYQHUjE6exwWmmO/jEBAIHlFz484+5iKGt6famittH8fQCJxvb28Ojx1hR7pcl
 RhTKGHl6EQ2iwgsHw5E52fx7yAl999SCzjhfmbCbv4vlNscUuDn16IJQpcKcc9Xf/juOFk
 BjKbU9XehbQpba1KIrZS5jPaTcCSO8cMnFWSwb/MlCB9+oQ4SIEwXdojIE7U+GYYFsX7dh
 k4bw8oGOqsDn89NI23e5XWXLs5S84soc+k0U/XUp0A+l2Tf4zcCIjRRzJdmGB0CjOf8IyR
 MobceYsusjS7uN7w5J9IHxATjP7/ClvvqbafVrzqzSqseEArbbNIB6EoFhsVjBiHZfhupw
 dzJVkQQxLS0iz9414ifyoEoaEwehFu+xJk2NCf4cUBhyzLWnXzhV/7k6Z/YEhSZ0EQf96+
 j7Vooyq9cIG/c81rOWAnZA10y/iWImkjjyKirfhXIT98Jd23iObl1yhFWwIRQrEm7uqHj8
 ru6eajbOOpLd4dlaqyX0UUdhDSsm5w4yyNzOlPErfPuYZDKdObBJuZz4ZQiA
X-ME-Proxy: <xmx:zKnGasNt7zCM_fIt3efu7kyAL7GR7GOvNIHmKOdeYyq-YAvxye8FwQ>
 <xmx:zKnGamP20HBdTK7pyjAlqIqAJZPCItZBYBAm5MGs31chxlOL_zEmiA>
 <xmx:zKnGastdZKwDalUr9MSNtPuhAdctTd7wL3TXxq-zUQy9CMpZMZTipQ>
 <xmx:zKnGagXNhX6dXDtW5RpCz23CqRAd6luOBiephjgTPqyYrH44pBtJyw>
 <xmx:zKnGajCm0bGPzEd41dOLARt9GPAQaF7PHzfeed28EynXdUmYcocqYwDb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 16:21:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4 00/15] Introduce RTE_DIV_ROUND_UP
Date: Wed, 07 Oct 2026 22:21:30 +0200
Message-ID: <5dBUPxkNSW6bGjMMFysmew@monjalon.net>
In-Reply-To: <20261006093822.603a7a2e@phoenix.local>
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
 <20261006093822.603a7a2e@phoenix.local>
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

06/10/2026 18:38, Stephen Hemminger:
> On Mon,  5 Oct 2026 19:30:36 -0700
> Joshua Washington <joshwash@google.com> wrote:
> 
> > Numerous components independently define the DIV_ROUND_UP macro, using
> > the same definition. Attempt to commonize by introducing
> > RTE_DIV_ROUND_UP to rte_common.h and replacing usages of DIV_ROUND_UP
> > with RTE_DIV_ROUND_UP. Similarly, replace DIV_CEIL, which is
> > functionally identical, to RTE_DIV_ROUND_UP.
> > 
> > Changes in v4:
> >   - eal: Fix merge conflict in release notes after rebase.
> >   - various commits: add rte_common.h includes where missing to fix
> >     compilation issues.
> >   - opae: drop RTE_DIV_ROUND_UP change due to shered osdep file for RTE
> >     and raw drivers.
> 
> Looks good, some minor AI notes on commit messages and doc

I consider the minor notes as candidates for follow-up or not relevant.

Applied (with a bit of squashing), thanks.


> Info: remaining private copies not covered by this series, candidates
> for a follow-up:
>   drivers/raw/ifpga/base/opae_osdep.h   DIV_ROUND_UP (map like cxgbe)
>   drivers/crypto/ccp/ccp_dev.h          CCP_DIV_ROUND_UP
>   drivers/common/qat/dev/qat_dev_gen_lce.c  LCE_DIV_ROUND_UP
>   drivers/net/sfc/sfc_dp.h              SFC_DIV_ROUND_UP
>   drivers/common/sxe2/sxe2_osal.h       SXE2_DIV_ROUND_UP
>   drivers/common/cnxk/roc_platform.h    PLT_DIV_CEIL

Would be nice to address in a new series, yes.


> Info: the Doxygen repeats itself. "Evaluated twice" is in @param d and
> again in the first @note; "non-negative" is in @param n and again in
> the second @note. Keep the @param text and drop the duplicate notes.

I think this repeat is fine.


> Info: nothing in DPDK defines BITS_TO_LONGS, so the new #ifndef guard
> does nothing; drop it.

It is in rnp_osdep.h, probably to allow including in a different environment.


