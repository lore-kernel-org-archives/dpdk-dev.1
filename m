Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED15CD6E60
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B324025F;
	Mon,  1 Jun 2026 11:51:47 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id E14244025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:51:45 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 9BF661D00078;
 Mon,  1 Jun 2026 05:51:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 05:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780307504;
 x=1780393904; bh=saMMc7xcyRyaoRVo+PiHo5OANzzn1iXjNuHdDdipVtU=; b=
 wTl5F+LaFp6AnDVnSGUg9s/nEFzN5Y7LTKoVpyARmSMHOJVLdjRunZM9IiwTLaLb
 0StlvgyOmKxOyRq+T4EqGQ3MZQ+ejN62fzNE1qELwaXubpqGs/2+DYG7GlZc5Fch
 xjRp7AIYotHwvxuv8EA8Q2/+LTgrOvRVkNlmO09A27Rmnlt4HyK5aG8VcOrljBCf
 CCz0lQFiYAiQ0+vwW64ECOdQoFVtzeMRmwuHXyKmuithAJJ40QfRWk1QLurahGIl
 EsDIhUm9gMbDpW+ZKNzlepoM9jJjmhs3g8xJ6GkWOFyJb3BQM2zHkLZcxuxfFeyX
 QJxFA/1V3T6enYnPMx1wIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780307504; x=
 1780393904; bh=saMMc7xcyRyaoRVo+PiHo5OANzzn1iXjNuHdDdipVtU=; b=N
 KvVdFZN8yjYsWYgdCga38KJtESE/wege7DKn9vdog3as6Inzj8ZjRpkhvFA+mQ9P
 0uBOeYkMw8njXi07DQNArg1xkSsq8mtb2VMEAVtJEgZXG4mcewY4VYw7LhtqtQjB
 fQO2S0G6TOlN5WToHE5S6PdMc1Zx8JKsh654cbNKoHsgoSaJgk+JOJH5+AJCyQSC
 bL8NHCkGgo7vbAmFVV9x520V+Y1fJ/gNDJmK+UT3rj0AHj+sEDorlBrYDSeTjSQc
 bn/rRMaS+atK+NVlOYafgAVXMboep1FfrDngtEBntyusCuXfJvC46toXJT3wdRDw
 hb1iWg7TSM/nsEwLbnh9A==
X-ME-Sender: <xms:L1YdatMjAMrmUS1RJjw0QNzHVwjNCvOXCufWyi6agvpA02AeM57SMQ>
 <xme:L1YdagFUVC0oprFXtb1eaLB598zrR_pzhBKqopYCwhMmObMmu8vbOepN6O1166ftS
 3TKqhs27VMN5xhGeznvtwz_0D2MCCgrmPLevRbfCYRPePdTNCNN>
X-ME-Received: <xmr:L1YdakO0H810JtWlrMP6_Lyd9sxheZDCWg3JBS6V-6i1mNSiHtMfyW0PKsQR779tnCLP73bpfJd2ti1NxDx9CC2tkA>
X-ME-Proxy-Cause: dmFkZTGGSSkrpXgAzgjBO5EItwzEhlZ240cmdZdPSNR4ggcIjzBhf68aP0WczxRHT+5AyS
 2AgwOgmGzQsGHYB7SgS0++0TPHMga6nSznNgOVmofTA8eVMaQ22jjaAlPQOv70/tRpQ59Q
 8BHEQlKWRQMZsEdMCpHGjt8FzI7gI6JcbM0LKv9SQyD7STWkmXZ1+dVVXUMPXVoAw1gFPo
 6iBYVGTwGCu+AkS3x7QqtxVRKIGxlxglArLbYIzQkzAhKzIeUqteoKIsqbGREZX/UdUhic
 4h1m7cnZrRytc8zLphPF9lINm9TDPifFvsOZm0VlZ68r8a0wXWNJpJ3tXvdgWMOEZRXZgu
 /zP/3CVhKAStJE6j+WV0SkbJv7us/cAXupOuzXAK/iIM6AuNqWPXpjO7zIwpbwaqDdL8/v
 yH7UJpwDoCiloSnodENFcxXqF+DzH5cDKaQiwScQ/cjon4Y41ZR75rflCZxTyj4SaU7zyf
 uoY1Is8i3lJM170WcrlNI3OZgILQRY0uCEiFZgCBni3PwhRkvTRg5kMMNnonBgYW01s/eN
 c+dTAa0ng/SZcSmHuMwRYXjKM5rtKBeWKTBUmQN3vD14TJByzGOFf9oEBdeSF5uZSAZIRT
 3EsFgqie9Va4gjmP1p1yPy/Sb5u62KM/90/7zoOmDTLByAxQE/LST4FZQEmA
X-ME-Proxy: <xmx:L1Ydah-zZn1NcxzCFcrEr414HkUb0BAI_r7iPPxJIMudYi1ON-RT6A>
 <xmx:L1YdagQsJhrIlJWBv5D-v_GhFZoWJgDgsd9a4oBGNVGEgxrkFoi5bA>
 <xmx:L1YdarljnFKPeYT3FmUlNJ9i_alJrei_neHXtES3zd_hfb5XuOtS6g>
 <xmx:L1YdaoTh-7crBXfGAK3IXunKPYXotmoyGBA0QzX0mZAwMIQOu6lvIQ>
 <xmx:MFYdasuw5qiHX2F6CVLUnTebboEcjBRIuCpSpfjJu-jJxKeH2CRRK4b_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 05:51:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address feedback
Date: Mon, 01 Jun 2026 11:51:40 +0200
Message-ID: <Xwaj3QZYS3m2yOc8mSX1EQ@monjalon.net>
In-Reply-To: <gMRpO5X1TMqg0ezYQiGHfg@monjalon.net>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <9XBXAO5XSSSHFRFv8zy4yQ@monjalon.net> <gMRpO5X1TMqg0ezYQiGHfg@monjalon.net>
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

26/05/2026 16:13, Thomas Monjalon:
> 21/05/2026 17:16, Thomas Monjalon:
> > Hello,
> > 
> > 20/05/2026 04:17, liujie5@linkdatatechnology.com:
> > >   common/sxe2: add sxe2 basic structures
> > 
> > Are you planning to add a crypto or compress driver?
> > This is usually the reason to have a common library.
> > If you don't intend to share some code between different driver,
> > then you should not have a common library.
> 
> We are curious about your plans for sxe2.
> Please, could you reply?
> Will you add another driver class to sxe2?

I see you are submitting patches
but you don't take time to answer questions.

Please stop sending before answering,
we need to communicate, otherwise it won't work.


