Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27ACC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6EBB4060A;
	Thu, 15 Oct 2026 17:24:21 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 04CC1402DF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:24:20 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 919307A018B
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:24:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 11:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792077858;
 x=1792164258; bh=gbtn47XGtD83iLNN88OKDqCU70vh6HY2kuXMUMkoMEU=; b=
 a5ANeo2Fp0CfZcClE0HBIT4GzyoVlrSSvjrWElDth73W3FTgOwFYVoKaPEFvIO6d
 DbW/4uP3M3r48RLucnFaJMPAmBm5ELbvNOREzr8kpnWlG6IGAr4HkGTmQoHwGbON
 42zkkK+SDl08KdieDktt3ETcAk42RbHB9+Y8r7KCjCByyq8qYaoIbciXOYWc95f7
 aYlVfZ+mDGLb1XNY7awBNmvOsRV06ufJ/j7kMv4+Y593DEsSJRc3/eLOw9el/KB3
 tZPXNohoHg0rKdMIb7JioNyLL9tBOylCgOOhVSofieujkkA/lATPpkwbfzjtqU/u
 PYXj6qPIea7fWjsOBTtl7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792077858; x=
 1792164258; bh=gbtn47XGtD83iLNN88OKDqCU70vh6HY2kuXMUMkoMEU=; b=Y
 9jrJ9aG1mz9DoTo+2bORXeXHdZfQqKMmWzOhxYKqWLSEgd+cJTpTnidbOoAkm/Pf
 02MBSyZB7RM7xG3FQhFwMGA/iXE3aRnoKP4t4hQU8iPajhQ85T6iljN0DvwA7TmK
 SIsGq5yF9UEmk+VUFRP8STJ2d8x10Yu4apxLx/VDUGr8Yq7gznxtfu8gKIWVu5Tf
 HqtcGr8gFZfpHw+Mcd3LrqfcREUBts6XzsqUTUH8OaCaRdVvs0JjgaJqoJSZgAHR
 3lUTfFv2ODV29mS8Swy8mBptfVCa04vYdl6tusKqbnDT1/PUn/cYL0Jx0PdvuG1B
 6aUUj+LoFeTo1CcRxxDZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077858; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:bebL2CDzq2xyF2oVII3rTc2KPDsUoixMZjotUPQbbCJ11x+
 o0KF5iXoqUTcc2N2tkF5vvSqfuBLoTydFell/FZiszF45e6CBjB/3WbxrxLt8vz3
 8kKN2nbN23RTkeiafeTLcs7vmOf6G81U012zuMZszlxrPmhUyjsZRqKpDmlRiw19
 oLv3on0M9Cj0Y6D8ATzSVqfr8v0++f/m14Vit8D4s+Y1ntdelCQmSnGubKp42kCx
 buPLXWqcuPSqEdAIDoETJJ0Sr1MchimjFxMwd7SewQalC7GAwmGWzV1ht4XZNaNq
 8oCU/amt3dE+NUmEm5kkA4hVpafHNSdVvJSiGJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:JmR3EswweafDn5mA0TPoSc7eeZTbGAaddJJgZNSAVpc=:gbtn47XGtD83iLNN88OKDqCU70vh6HY2kuXMUMkoMEU=;
X-ME-Sender: <xms:IvDQaq-uT37njowNVS5eK9M9B3SG2UhcWQlEGT_kOC8me8azujrFxw>
 <xme:IvDQamuY6gr0FhorzEvLWJ0AfQLHlwCNztRdQzWI48NBZc0EcZeODi0G8G-OVHqoh
 9ghY5AwG30_WHCibZoDmQ3cpWjiOnxrDroB0YSibTfXyj5983BPHj4>
X-ME-Received: <xmr:IvDQaiNYOjoJnaW2qzLs3Fanz2fo17_rxuvw5Qh-x1BgYOE9G3Xa_lWdTPxTQvWKemJCzL2AmfcQjruAmZAHezs>
X-ME-Proxy-Cause: dmFkZTGr4OMjq4nyzcrps6+qpbb4TDia0Owb5WcfxrcHZA3IaS7JhRguLGQEbsxTljLL1s
 BK0BPF/1+Apth4SNNiuQ1o3YOG0CtedAcihyB36lF7lr+Usz0Kf1EksTdYXmxohnZETnTQ
 xthXKuo3Z+ZcsiZlNgh9s4FY9LoJwFgXq9jetJmxHfoBMkYzqy+O7p5Fwmfd2AIMDoW6yI
 E5E+w/1BZMBBdhjRqiWbU+zUn7HmlSOw/u68hmUk2r1Gq44YzzvR50d/OZMCee4sda1NDA
 gfCCxr4V32mp3n/aZpw8zSf8ejIGQJ4s6A7htHPh1o+x7XsrG1WnWJwHiY6fDIRZoooxtV
 KJ2ggzRXOlZ+kTftFftE/Hzt5kY2mQX6o8THJK4S39QUHcjgZTTTNmjrlZUj5G7v9fIT6e
 eEjyz2fw7AEoacw98sBkQ5wu3AvjUEdVeVciNkz9aGBsodjj2v8AVxepOQE4jXRX4Li2IY
 6etUVQoSdCneNzU5rDC3cREyjUDzSasOhJBcu4F3lIfZAfjS8YK/ic0DbrbMJO/gMrgN8U
 jRRoZzKqUS641pjAGF4rL9Qhewjz3pEcRB0jx7+eYlS8uWxEhpHCBjAFDuWy5ZqxYoF0Fg
 VDiqawT20Q9+TIfxvYK+XQ1ay2BwH36ZJTgRVbXm8sQ+SJZtZn1/JnLDq9ig
X-ME-Proxy: <xmx:IvDQajjZ_gJFBKabU2nrHPdPDVJAlX9FB64YMmgtKtSlGQLdf92OWg>
 <xmx:IvDQas6haJQdU9hKOzdEfK3IP03hfl0_8EQ4TegVNEkYjFj3veS_6Q>
 <xmx:IvDQai2uYA3-gDf4wkNVmqJ0AFqg1KQRhBVvmgOTkhiyXT_dCES36w>
 <xmx:IvDQavvGoqfuC7x4TpvjbSD2SN62KURgdSsUBNlhgP12RBH-xnTBAg>
 <xmx:IvDQaqZh09ol-tPMW0BwVRQ5AFipN-KJ_EcXsw741fe938yTvCNMMIDV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 11:24:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrey.Yudin@infotecs.ru
Cc: rjarry@redhat.com, stable@dpdk.org, dev@dpdk.org, jerinj@marvell.com,
 kirankumark@marvell.com, ndabilpuram@marvell.com, pbhagavatula@marvell.com,
 yanzhirun_163@163.com
Subject: Re: [PATCH] graph: fix xstats of cloned nodes
Date: Thu, 15 Oct 2026 17:24:15 +0200
Message-ID: <JXobh9QfQzSfSCUAg8Wh4w@monjalon.net>
In-Reply-To: <20260715063215.3892836-1-kirankumark@marvell.com>
References: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
 <20260715063215.3892836-1-kirankumark@marvell.com>
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

> > When cloning a node with xstats enabled, xstat_desc entries are copied
> > into the rte_node_register structure, but the nb_xstats field is not.
> >
> > As a result, the cloned node reports zero available xstats,
> > making xstats unusable.
> >
> > Copy the nb_xstats field when cloning the node so that cloned nodes
> > preserve the xstats configuration of the original node.
> >
> > Fixes: 070db97e017b ("graph: support node xstats")
> > Cc: stable@dpdk.org
> > Signed-off-by: Andrey Yudin <Andrey.Yudin@infotecs.ru>
> Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Reviewed-by: Robin Jarry <rjarry@redhat.com>

Applied, thanks.


