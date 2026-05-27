Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65523CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 08:41:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EED34028A;
	Wed, 27 May 2026 10:41:23 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id BF1FB40285;
 Wed, 27 May 2026 10:41:21 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 85B991D000F8;
 Wed, 27 May 2026 04:41:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 04:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779871280;
 x=1779957680; bh=wngK9nUmCsiUSXcSIdzSkK27u1PAiVCu1c2LeimeK4E=; b=
 MyYf4hEqJBxEl7oUCVSBmy/zUzn6f6V3ZtHd8t5Ag+V7+UUo5fRAo87E43XCH8QJ
 MJXZje7OclBGKYEZx9opEdUpzGEtCBryL6ZjF27txyFjs1/ABZEiFWmh0qOrf98A
 iW0WYkVO/0Iwq09zPJBE0rr+TuLkMcTpRzCeY8hy7E7XZo3AjMsXLQcJya+2AHS+
 eK8fmalNw7Ijeo/h+hED0/J4DFyrtF5zfWNGdbqleI6knAuy5oMTxyOmtCBac5JK
 xli3TfKooUCvXYMxJbVylXYgMvSCT39cAAZBv16PIM++n10Se/UFR9U6Ip8TYi0A
 EEQeaGbdDTU5euvu77U9aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779871280; x=
 1779957680; bh=wngK9nUmCsiUSXcSIdzSkK27u1PAiVCu1c2LeimeK4E=; b=Z
 /XxMOXZAPEtY+BwHnaBJhBf60akP6eQFVCDHuI7TWFPdDQ3u3KWcD2lvAGAqEgSC
 alolfdtFIOs+arr6qJyBBR1YwVdte/Y+9fioV3egyUCiYu8YdAahtuS7gccT74Tw
 vRvBSO0kMekosu/mSE+fQJ6VEusqyi9tpvWlGxG/8MjfvYjvGiT7qdha5877nHVX
 i5W6wFinXJlSA0b0zCrPx901PdHJGidlHeSws5SFqxh60Q763iK6bsKFZWKxOdvy
 VYBYi6SzVK4Zb3GsnnvNLT7S89kH1QDIVLJ9YhybWnrwjNz6NB86TEnJgpAuT8FN
 sHVcs5ZxsVZ5UzqEBJ/XQ==
X-ME-Sender: <xms:L64Wau2TemXa7J_BNsflJtUl08zzqmpieGIAQxTQgZ99-Xk_gtdzyw>
 <xme:L64WagLl_MhCfPHofIO8qqOeRaKEVSyfjuCtc23Jij7Q1DcNBZs7a3WbJxCYzREvq
 j9WXUVJCv51FOISCqOZ_7phxKzz3JLi26xdYCjTOFVBlUnt-LRkVw>
X-ME-Received: <xmr:L64WatEL0jYDUDgIQMK5iLO5sE0feaxg0vw7wnsPfL8ZXgbcamIikQXCR5lEj9Dpgp-uaXK18kzg9VI0NK-4qYDmBg>
X-ME-Proxy-Cause: dmFkZTG22GAjO4zy6rEo1IpT8I4zWHpwD209oLYu5RwZF5ub5qhFx+C7AH3TpL+CEt6j2l
 J96h5fwi6vMBzJQvyyX7ku+Yw0Nwv13qsLI7MPP1wmPkIIzbaW17d+IJ7gNshe/W2nUQbx
 Wcx+SOGDcUcf4R+yMOCxlafdw+MnkzBFY0p30qydcmZgUEwnevoxfBWRaFo+cJdAs7JNBc
 OoHy4z5OP1h8YQph89l945DuVQ0eHydmdPYjNrFN4qz98n8wxQ8sKYunuykzzwd8yC4o34
 KFZy3uvspACuJMLifdFlDB8xhK6UCdBr1/WotYDsrqan5reJS9tlK8FoHYMu08rmyriJW0
 IGxGQ8m8+s1AVKgsW6K/5AFPRGpnlX5u2NU+4Bmp4zfeupab9iJIk2Zqh/Q0R/e+Zl6Cnt
 JolqDfHGiEQnzbZAsmWewJhT8EOEjb9wa6gQfL5x9Cbcq0S2A6B4o9aa6/zab20RfXoIVr
 oDOjAXUncgnUenAONnzfIUE9m9JDoYYesXs7OpXozCNd9ZlxXqUIWatkNwCuPZcvYJ6HPv
 9zzRA2HsuNzAN0K/C9rOUXBbcZ/VKHyQKVh6xHn6XjQ8Wlgqfn+7JgyhhVarwsYnIGILpS
 wyVQbk6D8rrgEFhANPyJmET0tgO7U+1OnoVDfW1YICjiDMMya4Slx2zIToVg
X-ME-Proxy: <xmx:L64WasXroaXfWCYW2WtfAx0pUHQ-C06gfT7V83XqnXFiVI6LE-n6tA>
 <xmx:L64WalzvnleSlagORhgT01pZNtTBhpjiRoWmZFpP0fWMibwislsI3A>
 <xmx:L64WahSQQGvQsN5THJOy7yFJ6438plF2Y36u-hHUh_di5rmvy8pVVA>
 <xmx:L64WahihIlledwEKgbfZ7BYh0zZc5RigvR6MvZspQIqLquU-N2ItlA>
 <xmx:MK4WaozNO9RYk6FqqA4nATvrEEqclHEY7dv-LZRlP1ZEPTupY0kAjXkO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 04:41:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, Gavin Hu <gahu@nvidia.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v2] eal: silence -Wconstant-logical-operand in
 RTE_IS_POWER_OF_2
Date: Wed, 27 May 2026 10:41:16 +0200
Message-ID: <JhREl7PiSzmieUUiQra_4A@monjalon.net>
In-Reply-To: <20260519135046.367128-1-stephen@networkplumber.org>
References: <20260518163401.580696-1-stephen@networkplumber.org>
 <20260519135046.367128-1-stephen@networkplumber.org>
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

19/05/2026 15:49, Stephen Hemminger:
> Newer GCC warns when a non-boolean constant is an operand of &&, which
> trips whenever RTE_IS_POWER_OF_2 is used in a static_assert with a
> power-of-two literal. Make the zero check explicit.
> 
> Fixes: 7c872b96983a ("hash: validate hash bucket entries while compiling")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
> ---
> v2 - use suggestion to make both sides comparisons

Applied, thanks.



