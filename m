Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E92C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 20:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3138A402D6;
	Sun, 20 Jul 2025 22:44:31 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id C41B84026D;
 Sun, 20 Jul 2025 22:44:28 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 606D2EC010B;
 Sun, 20 Jul 2025 16:44:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 20 Jul 2025 16:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753044268;
 x=1753130668; bh=Gcb7RrkgPZXRL3wzY6mJbwu4YYmRFL1kxjSKsYCX/fk=; b=
 Cvw2anjnVrgd1k+KMYXvp53TvfOhdx/eWa8Grl9kcnSHtmN1/tHKf+WxVRsS+4lp
 IM1AQEiCZOJartAInfxzyFf3EsIFcL0jIkykfuaMhawozYK1kT+sDso1nTEnvVVQ
 FjUNhr7QnQANhUbnFTBDGdJA6W4K5W20HK39kEss2TAGtWmSgIVKKPRjdWxOcrc4
 NS+4yzHuSydtySOjpYKfmoAvpc5Bru/YGNfA7vBMXGwqHai9PviOuDuY+pZVavJs
 HP93ud4Y+KVE/pV7p+mrfX72U+vN8+3neJSbEvGqbBPQqU6o8ZMeoigcjOc5lYhS
 cWbSJRQahY8uArnvU4kDmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753044268; x=
 1753130668; bh=Gcb7RrkgPZXRL3wzY6mJbwu4YYmRFL1kxjSKsYCX/fk=; b=b
 eEEySnUnydQsXihLkbn3xks4+a7USbo/o+QGGvH83RG05sBLxmFw7QMbbAyTIJd+
 6+P8y38JDbYtk/fQztjEYTzfbkhmFEwaY+1Y1l1VFg40PeRq0n79IrhoGxEAOLGk
 wQcBiwiLzAXahMF93conU9WvYoIUF13pDaWU1ElDS3vn6C7eAchWC980bM+3S+fb
 wrQTd6OYIsN4HdACLX3TriUKv8LbxbZhzEfjVsOka08MhAQwfTFiAcTMafSJyPVQ
 cVjPaSVOk4O9DzXuI2Wo0kztQqBORk2wsbz8hXSIuskC1XjDK04zc118djXg1qMG
 TYlmVgKyas5UBR91vsYTQ==
X-ME-Sender: <xms:LFV9aJxsIR-yYQSnBXBIsY7BbEY1bIi6A1ft7GI0TpPCMJwlr5gKIA>
 <xme:LFV9aC4ZNIwy84xH_r07ExKgZKgj6BJYedsJ_dSJQncCU0_eqA-XiGOETpvyWmFH7
 -epZO5G8RgvUc-UXA>
X-ME-Received: <xmr:LFV9aDUECE2zvwaeE2bQygxkFOlvRYOnSiE6a3J4iwcBiUDmQChlf88GK6H7M4R5_H-R5Np7_vIETg3Xp-6TlWC6Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtddulecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprggtohhnohhlvgesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepthgvtghhsgho
 rghrugesughpughkrdhorhhg
X-ME-Proxy: <xmx:LFV9aO1wiwvElPzN9JuH1LR3aWkR1afTUSKRX0GvjchXmZqjmeEzlQ>
 <xmx:LFV9aI2GGrua0xZtzBHlD8FJewaTBJDeeKU7tXMn47EQC2C8fXHAbg>
 <xmx:LFV9aJ9zizl6ww1n28BT_YyrSeT2htQSp3RIZlhTM7RvqLUkhoZeug>
 <xmx:LFV9aN2VZk3lFVqWHS6I4Iv4tOUOL6dSYAviB-IDYns2YY9cYaVCWA>
 <xmx:LFV9aFfetdsyOnSlZkDanWW8JcQrKYWTp4n_ZCFtkes-n6-Qc5ywCYAE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 16:44:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [PATCH] doc: Document frequency and volume limits on patches.
Date: Sun, 20 Jul 2025 22:44:25 +0200
Message-ID: <1978264.taCxCBeP46@thomas>
In-Reply-To: <20250417181211.727663-1-aconole@redhat.com>
References: <20250417181211.727663-1-aconole@redhat.com>
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

17/04/2025 20:12, Aaron Conole:
> The DPDK project has two constrained resources - reviewers and
> public CI infrastructure.  These are shared among the entire
> project, and there are true costs associated with using these
> resources.  Thus, there are two motivations behind this change:
>   - Encourage developers to spend more time ensuring their
>     changes are in a state that things have gone through some
>     basic testing
>   - Encourage people to give reviews by guaranteeing that the
>     time between series is long enough that comments will be
>     valid.
> 
> We want to document the guidelines for submitting to the list
> to encourage more time for reviews, and also encourage
> developers to spend a bit more time to put their submissions
> in a 'default accept' condition.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Fixed links and applied, thanks.


