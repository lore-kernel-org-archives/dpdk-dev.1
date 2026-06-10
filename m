Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC50CD98C5
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 20:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF72427E3;
	Wed, 10 Jun 2026 22:42:12 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 4991D40666
 for <dev@dpdk.org>; Wed, 10 Jun 2026 22:42:10 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id B8E7AEC0104;
 Wed, 10 Jun 2026 16:42:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 16:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781124129;
 x=1781210529; bh=bGHQAW1TxQ3CmxV9RCTcWWZkFOKUVur0LbZmZt7ynLw=; b=
 HzG6f/q/49QlunzTDlr6YtEMwBGr+58WetqhO8LkgM15lNGeCAYJbKePRCkZLFRm
 9KocJ2JswKrJxKPyyf01nYk5bmf2dQNKxqhyXpHzkiZVZPH2d62H4pZhgNTQQWdn
 E5TdNYe7v2RQmJTafwJqJhbGcfG1Ylg3Rf7JK1Pkc3QTO7I5+AszFDqdexUc7FRa
 187eFJssUWj7+cXkkc7Vp2MGZmaglMvP5v3ikgEz9VxBfGig/CyDncKiv4Q3MBOR
 i4aGumm9SekKisiXZhbwrfurSK1ftWD9PEUcWEGKkiGA+GTlqiGkKNY/RwwiocGK
 nHV2MoUEkx9I+Cht7+y80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781124129; x=
 1781210529; bh=bGHQAW1TxQ3CmxV9RCTcWWZkFOKUVur0LbZmZt7ynLw=; b=O
 anFdDHJsrAWzHJDn3GTjqmS15l4KuDlHx3UM2aq7HXVc9N8Jqbt6sdkj19dmG3hd
 aEHOgIUQMc/Y3KiFRAmoBBHQNH5Y0v0GaeHPubIZN0EJaHo+6rodREoFSJQgS+Jz
 hQ+1usrq7mOXbF0+O9RZV+cGnVf/Shx19Ah6C7VncMdUpolrVYYSk732UuXKOMeN
 3nnkMkSq/uX68xIAvb9XrIaCkyRLIcfqDnJbpJ3bjW5tZIUv7SIqXfg5c1AiCfBj
 rL25cn3tm41OiReoUR4dVbiEMY3/1x5HnUi3KnT/SuZKpv1+miGyup3QiufRh03l
 HBHlUUZn3w2rg80ej5G6Q==
X-ME-Sender: <xms:Icwpam---4vGeNquQtISXmN9tZvBSM6QLKPcZCnkWcLYthF8kiKl7Q>
 <xme:IcwparC6MzUZCXNt5Yh0R1ianvR-v7_90NEp7ML7aOSLirr2-wqWjS7LKYDOr5dc_
 NNqy9YxHdDCpAdCrEHW77CJGUteK1F6UcyeazQwWfNlW-4pE-18eQ>
X-ME-Received: <xmr:IcwparJPlbZ4-KjqU4b7FjZyAgLQ9-OPV8830tDZugchcT2UWIbXgP4eddbFM7PkWXHOZbYtFZzJ1YK9T7_832NsgA>
X-ME-Proxy-Cause: dmFkZTE1Jdm5w35/qToEUQHc+BcaewJxhADZlsfET5xyisq3A+wNWQqacjdyKPpV98N/vO
 9oLzzkERlW5yjG5jL3gxQvA3lcE5n4hAZCS6g9MGUB1N9dLLYf8zqOCW2WcABkqhKKrGZC
 4xpNmxwhgKmQ0jH015cJyelIulPM6Bj4zN9yjBOCub5qrJtfodXuLF35QylQpAf+FFPUqR
 sZQiQLlLUD6qX8sfiQ2HKbVrsne5+on3cpT8Aia/M5yU11Q/+EC1XEep6kGIZCnvXVPjzx
 CVnVcvtrtaWlL1vTLFLMAB/5EW9PhlP7OB/eqFLh1SkPDBrgHiBQ4GvYArxqc9cNgg1kU9
 eNUiQitPZTgXq4FWq7AVqQ42LUNQbA2ZDxWrzPc4tUCVz3AZq/6uCspUhNQGeWHwIeYn5b
 43GFWPUgP5pPU9N0Kv8CsKDvEjN1wP56VV806NhV4sByUV8+ftUA3D9vMmuKAOL/n6TlaO
 AVtnHQvYu3UXX3vbY29XNn4uF/BLbgDwI7lHn6oBDJQXNAsOh6UOrRIUBSIno0qziQ1BvU
 kdYJkaSNiFxrp+jla03rLsPI699bpkMr6GLrqEBOe+DucZQmy1BzjMgmf1wjh5gU3mFubu
 Oti+IVWo3ws4Xq/wFctNnIrquJlnXU6oD0ORkvL6tOYGvngfcbGilJL1r1Xg
X-ME-Proxy: <xmx:IcwpamnSFmm21gfEPN2iUNSe5PwBbztIEID6VCHm6u6qZov0FT6JDQ>
 <xmx:IcwpahH1C3tGywdgEAFOSWnHNKvXAwM_wD05QFnTVJsjWZFBPPIY9g>
 <xmx:IcwpauEhu7TTWBeDVxqw2hl7fGPZJgKEwyO93yHojcqT8epfVa9P6Q>
 <xmx:IcwpamMO69f_l34GPypfbcFErkHATBNol0tO5R2vuR4HTgyppkMvFA>
 <xmx:Icwpat7965Ewt5Il4VpriUFZRZH8MElqEKIGH2WcauLDEG_aY47MF91P>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 16:42:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 0/8] telemetry: thread-safe and bounded parameter parsing
Date: Wed, 10 Jun 2026 22:42:07 +0200
Message-ID: <ATaPPyqyTN29X-xgYWLdrA@monjalon.net>
In-Reply-To: <aiZ1jB3_MaDP4OTK@bricha3-mobl1.ger.corp.intel.com>
References: <20260605205253.520196-1-stephen@networkplumber.org>
 <aiZ1jB3_MaDP4OTK@bricha3-mobl1.ger.corp.intel.com>
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

> > Stephen Hemminger (8):
> >   telemetry: fix thread-unsafe command parsing
> >   ethdev: make telemetry parameter parsing thread-safe
> >   dmadev: validate telemetry parameters
> >   security: harden telemetry parameter parsing
> >   eventdev: remove strtok from telemetry handlers
> >   eventdev/eth_rx: fix thread-unsafe telemetry parsing
> >   eventdev/eth_rx: reject out-of-range telemetry adapter ID
> >   eventdev/timer: reject out-of-range ID
> > 
> Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

After passing the automatic AI review in codex,
it seems the review is not relevant.

Applied, thanks.



