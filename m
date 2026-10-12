Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CDCA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D609B40279;
	Mon, 12 Oct 2026 23:24:13 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 47C5A40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:24:12 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id D15B71D00140
 for <dev@dpdk.org>; Mon, 12 Oct 2026 17:24:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 17:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791840251;
 x=1791926651; bh=q1NfOaI1QQdwEiKTrH9S4y7su+Qa4jgnT2GJgpwQco8=; b=
 PGCbzgPYWXUuyJE0ijtKxy1pkBQrg249D/p2Qy1kLA9RtWmRkPdVE5AfwU7rFTni
 w4soLHHLWhktYWOBAZOAGhooPWncFSyJnpkNy2PFNsw4Qu5nvwIUsTIjgf/4CkTv
 lPgZxeONMRLj0yxrXkpCCTpvwDLs3lel7jK/O746PtQl5WfqgJkwT0OLBpnq5RS4
 jaGqQ2VUgaK3C/NSafUIM4Fna73ysVkmQZ855dwYc+DXPAbSTlslilxi7Y8Es8h1
 84ui+8R5LGr0rpvTNXjsZFcvJA7VULspWKpka3y6WjqDmvwybgWiKoWutBk2GeXz
 eU2b7CtTOVU5EVBUuj0PHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791840251; x=
 1791926651; bh=q1NfOaI1QQdwEiKTrH9S4y7su+Qa4jgnT2GJgpwQco8=; b=u
 w6Vl9hGlBychGcFRiPkxAU863PQMFj74N03JQLXoKGzQQzdC5bxjbjufPl6JzFQv
 GfODR0s1EKVS2F+1gaZKxw84IEqyPH1nMhEhVFoE0yTx+tMrl7wQUuzmjWNA8qfv
 YJZ6o0vsuCBcMGqj89Pb/glib+95tLT7orl6Xthft/AyM5vG27yOq0IGjzBhnqvR
 wbkObP8ntWJj1pyllvH2jprvaGIcu9ynkkM+G6oaiUEwJ7xHKWCvzIvpMJFNgN4M
 zu8VKiriiznVNHWiYqpIcTpwMa3hzK59bJA4qy0LXSyqK0t6JYebCo9YDLwTF4N8
 l3ZNsMCoEyx/6gah++YPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791840251; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:gm7V6k3FKGBY1gFq1iFBrW17HQsPNJiJ16py1mBg6EEh+fF
 J3Yo2rr/GSnhmBPrJYdBAFCiFZ0gvOtVJLlptz9F7QBGsckGDCuKQLZ3E88Ct/R7
 hrv6R2jcKSvC1eXjyqnISQjv92oxb9Rra5TX3OEqQV25lAokxi/rUkwK2fOUgGQo
 R+wiymb3lShIJXAM5wF1zPQr/L8LaCzUcctg8AS358AXy/03rCULQgsVOZGcQOJ7
 S2JVNSOmEnG/QRRKI/kF5G8O4YU5PI+wD6UsayD+QjoZ24+uJFzda8rHS4M65qQi
 bvy29kBvKbbXFHrkfczZschrCS9+PwGf/e6DcRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:f/GR4DxE4dV/wkbzDKAOjcxrvpGwOuuIT5FZG3lfhRA=:q1NfOaI1QQdwEiKTrH9S4y7su+Qa4jgnT2GJgpwQco8=;
X-ME-Sender: <xms:-0_NaqJj2090LwezpB2s5d8ovTKEDBtRRCXnJEXfTyFrWZ-aliiaDw>
 <xme:-0_NatlF278ctwae8ZInVgu_rgr93KnpWfnDqyI_LaaYuO_EgGX7pb6DjXyrjNn46
 bBKLL3Plpr-r2GMyBkcUn_-RiovF4OYfF9Y9CWmTdGTozQmlmcXRkQ>
X-ME-Received: <xmr:-0_NauPGFMt8aY4noBBoDAu8TU7rgYIoiv_rtCj93BhoroQTWcMoWS-2vyXph267z1Q4JyiJ-mh4KuQVbg2y6UU>
X-ME-Proxy-Cause: dmFkZTF1n3VRN1RExhB+xDAmFJv4e2ITmIGjA7ntE+FY6m9k/CRXZusjFGSIORaaL7EPzH
 5mOdZIASjs75p8NO8Gkl5m0GUZ3y0EpppXYnQJ4+CHQjt1yH4ckQ0FxIWg87sHbNFxoQR4
 NBYtSbsD6LQ9ggX+TIu2AEwKGlWKnrPD939b0an/2kudpAeZmV4MuEQcTyiicQkykxSSUP
 iIvlKEIKE+zV0mt5XUvpAC2H0ze9CLHqEoP6V14OY/Rx7JXMLiUcpUIrkI3ZrFqhDtprkT
 mqewN5crPK6GdTCYdfiGXjkFQUOIcx/khuJ3vZy+2PvRZU1Y0amdzSkkhalmf9Dmp/wxbF
 AhWUjrwOjjRmQrOlaPgBnrvAJnYsUmQ10km31xqH0ZbUXKaT46AqJ8JVEvGLWH1IMq2xhd
 ptL4dH6ZofTvXlqYpaSx4FopQVNCZEJxzZr6B62OqqU9cPIE3vFRUHkvGCoBmmazzZt298
 V5MgjwwbsAVoarqg8cnWpxtEPQpEQgwDH3RtC5X2a/uWtl5wJbm8G9RQWPfQh9m7A4hoXg
 /ahz3D+4Nc5jnLfRfRrqtT4RVxqLAR3W8hPfHqdLC5OMUzoAefIuNSLEaguTmA0SUAiUu+
 E17o1NkmAAExDQKI60rnP3pipBjK237sZw2aBPiVxHVOAU8YBbfT09DuWcOg
X-ME-Proxy: <xmx:-0_Naj2H-XDIs7CMFZI3OBdMsfYhIgaq4NSvhYMBPAZa4RPgLTKeXg>
 <xmx:-0_Natn1DX_xm9d_kZAuWrWNwuHAk6tVzCSFs9_ftuqsHxTij6hbPg>
 <xmx:-0_NaqXNf_sa1BLDYT4RFbmZasqb1BQbtpARLu38gZaEho-ZWpxuuw>
 <xmx:-0_NajuKXsc53aeUOSseYI7BAB5RbTtyA290Nfo9Fed1Kqr2rledJA>
 <xmx:-0_NahZTxWi8rpYeTDQ-y6dTGHH4ZlQL643D-ml6m1COZ1lzdGnF5hNQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 17:24:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org, Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] net: revert add IPv6 traffic class and flow label
 fields
Date: Mon, 12 Oct 2026 23:24:08 +0200
Message-ID: <0fcPPI6SRfq0cntP9byJUA@monjalon.net>
In-Reply-To: <20260929073601.2971197-1-mb@smartsharesystems.com>
References: <20260922163640.1144749-1-mb@smartsharesystems.com>
 <20260929073601.2971197-1-mb@smartsharesystems.com>
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

29/09/2026 09:36, Morten Br=C3=B8rup:
> The IPv6 header bitfields "version", "ds", "ecn", and "flow_label"
> are not organized correctly on little endian architectures.
> On little endian, a 32-bit bitfield is allocated from the least
> significant bit of the host order word, but "vtc_flow" is stored in
> network order. All four fields therefore read and write the wrong
> bits. For example, setting "version" to 6 writes 0x60 into the last
> byte of the word.
>=20
> "ds" and "flow_label" are not contiguous in memory on little endian,
> so no reordering of bitfields can express them.
>=20
> Reverted the patch introducing these bitfields.
>=20
> PS: There is a GCC attribute to fix this, but nothing similar is
> offered by Clang or MSVC:
> __attribute__((scalar_storage_order("big-endian")))
>=20
> Bugzilla ID: 1679
> Fixes: cba27998dc81 ("net: add IPv6 traffic class and flow label fields")
> Cc: stable@dpdk.org
>=20
> Reported-by: Maxime Leroy <maxime@leroys.fr>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



