Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48351C982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ACA44028B;
	Wed, 16 Sep 2026 17:41:56 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 838AA40264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:41:54 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1CA51EC0102;
 Wed, 16 Sep 2026 11:41:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 16 Sep 2026 11:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573314;
 x=1789659714; bh=vw10n2T21tPQdWm3Ha2I6+Ybply7mJBLliE3bS3WQbA=; b=
 Tm7RbrtbsQW8XsigJWj/jnZIFISRzxHR1RkTTk9jbfmKWdyRxFF4tCCx3/lFHJ5r
 EfSlfzlEjEDaFgAt9M031+7wGb3NLQ4oWMVX01DiJipSy27YExHsQp3atxhvFQO/
 iJaMXWSWFEFIgexTkxjCmCAAiQy5uROZRorKJUGgtz3tR62ZvsoS3fJHwm17bE2I
 Z2kA+2XlDQzfEr4a3tec8Y+s/cJtS+3687SdEoTQ8pMlxKdsqqZ/JNizwcQomAaT
 N6arcrOAiI8HQHKc0KHjk5fozAYmuDCASdfPSUxzXR/yK61hTqRqsw+5Kwam8taz
 CuuPiHH9a6ejTup8azS0Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573314; x=
 1789659714; bh=vw10n2T21tPQdWm3Ha2I6+Ybply7mJBLliE3bS3WQbA=; b=y
 LqoTxXwOufgTy+2kgeIzrgSSxC8Mmzegrs8Lha5BtqTFJC5NwXhlG6+7hGgsCVjs
 O40TXrFSp6DxxJaU31mKsrXWC+IF0fhYjWwFXPH/ZEDAQZI9wnA/p0txaB53guiC
 BIXQVK0iOPxwBVKiqXv9CtCe3VNYoTE9Xtk0jMsV7KM3HSuSePVylmMfEEIWALG0
 hLUhprDan1NgSKVWkpE+c2HlpG4Nz2Fkr7w77czhgTdxOV6L2lnKgWh5WLrofMwl
 S+GXEG01kPCjFPzx3ULssrmiHu7nV1FiOO8SloZTd2e2dOs13kh0sOh+2lIjrm+6
 OGXR2Ka3Kq5e8f/aoF4fQ==
X-ME-Sender: <xms:wbiqahU3ANgfDMXPBfdzAc9PoSi9Jvb4zhDThdnpH7C30EZuZ9Ff8w>
 <xme:wbiqahvTgTGboUfdRwXfYmouGsZiGxf27AJ9VE1-1VZiJzM3Y96KDndYpYblqm8sL
 u3GwcWh32YBHE7AsOo58j76ztYqBF0e4wIqo2zDUCDdBJh6itSlqt4>
X-ME-Received: <xmr:wbiqalUuqCzwSy5x3Qu7A_77uGwQm9yqGqPuwGGgRuji3uenPwb0Jgqp0tysYnmGDckmQvKbG9VLUYraZ7HsJY0>
X-ME-Proxy-Cause: dmFkZTEF9PEiW7xGAG5S4DhGHBp5mwhDP6vtHlzRDpwoBIhfwSjilwVMiXpgOmNXfR4oOE
 bghfGDCHUnVE2dB+rrX4BzLePFwOR3GvfrhCvlq2DPz56UZdvQ1xdPpowO2ymS+C9WScJe
 P8XCyIogRs2+BceTQJUBSLppr+vi7Ljo9kt02Gi2UYFu6PV13dz3fXKkosKWmWb1SgpFPR
 nuXnGdjD/QP4oo5mzoYLsO1EUOw5s1kiYVkvUGNPWVbCoEK0DCMICaIYpe+JmX6lWiurO+
 /k0LuddQ0zraPwPNWOOVuKe7AovRIHAsLNMvrfwa1SJ4DtPov9GXw35r+2MZIxc3alxJGV
 rQRxeGpOEhHGAAlbFjPMizPwVX3Ys2H4x3JJ86Rrmd7fbxt4eCoBcHESO0imGHTBYhodWJ
 qMUnzzsIUESAEpcd8GKle+mbiBhS4getQFXZ4HYjS3phXOBy3FwGlN8hwqPHEoRV61QJwf
 40BVL1bDcBEoFNodCZdmC63pjT6GyrwuXdfleAXxW4dwrLRGkjFhpYwD8b2B43TjrVXgGs
 xUVVJugDo7KCH3o8oNkyr3sJ8VLyjueuG1EV/8RF11U0dSBDZ0f5hHe6y1Zq4zRVMwnxsu
 noNhTRH9KLTtk0ekDOUAjWLaEBa4xL10ll+JFVqfxIYzdgBG5T+YAv9prxiA
X-ME-Proxy: <xmx:wbiqasnYxuzCyMz5wkv-0YMMf0FJbm42S7nBRYO-QJcs8DEysjFMpw>
 <xmx:wbiqambxpAxNxs0HZ3Mm0AavSoQkZI1iqiuKrHM5u1-LC6wJSqdoHw>
 <xmx:wbiqanN6RGrZtlLQbJmuWMMZaYNzEBNmckf9CeIXsSNzgV0yRLzLRw>
 <xmx:wbiqaraqcA4guyML0D07b53qQrE1orMaE3Cx5AweEW9GjpFjgrBIQg>
 <xmx:wriqauSJzF36xXDeWvWVi8i-CJanc0_E-Yl8wUuTJrewzoY8TUYW40xM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:41:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org, drc@linux.vnet.ibm.com
Subject: Re: [PATCH] maintainers: add IBM Power maintainer
Date: Wed, 16 Sep 2026 17:41:51 +0200
Message-ID: <mbtuwHynTuSUZcLgSEnWtw@monjalon.net>
In-Reply-To: <20260915142349.1249543-1-rileyf@linux.ibm.com>
References: <20260915142349.1249543-1-rileyf@linux.ibm.com>
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

15/09/2026 16:23, Riley Fletcher:
> Adding Riley Fletcher as Power maintainer.
> 
> Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>

Applied, thanks.



