Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F55C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7609D40264;
	Tue,  7 Jul 2026 18:02:33 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id 0E5494025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:02:32 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aeb78090edso3347933e87.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783440151; cv=none;
 d=google.com; s=arc-20260327;
 b=Ut89K8c8x2thE04nYfnc9hHzgX5/lY6WwZy36AC4veyHmeJpDPB0eTMRtZ125T4/eg
 nwFwEDyP288qi1NX7Yqb/K6MgwE208vUFpwvnvWggqygmbN4zVV6LE9RHJFzvdIr8V29
 59vpFhUqwPi/68YlZrIKsoTrZ7XtYDMdO2M9x5wQAWYdEOapY4luSp1L/NfXfhFLxumI
 NDvCLsR3EcFP+RacpOHipYMQcK0d4B2s5aq/2MyUJ1Q1u2zg4FirdMImgPkbTBINSc2d
 nCRx6FiIYXwtTNSyj6xqiMEqnBVJtJbxsEy3S9u7PmZ0esagki3Vhp1HCQTpVsjBUo2I
 DvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iCosDLrehq4m5p6p5M008ObV3jYts/9AXn26zWzUnOs=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=EPLRIKwSfMrsIzsRLu7yaTV+0sX4EKrcTrxQQXwt9dOxPXrFCinavNITNeJJrZgnIC
 xM9eO0+yopUa4Vv1uOSue9HYHZfL9YT8zlKwaQwG636crHhUniu+zoo9FYa4Uz0k8vEt
 wrBkETAyrDIAnF6J59t1HHuAoS3oa0emCboh7+WwQoGZq1I0zgfetyYb5P0Yd9dKc189
 8K0N66UXveUDIPDc086qojhOy1ULtm4AvYhe63jbHyx3E11OQQHBnYAqOl/1bVbbYtIi
 T188w/+UxxXSovakm6LTbXkpY3P7t0zxF5B0vBtU4lkGRucg8qdA8mq9jE9ppkJTHp2q
 BwJQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783440151; x=1784044951; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iCosDLrehq4m5p6p5M008ObV3jYts/9AXn26zWzUnOs=;
 b=cucivFLeID9VHXL2tX+m+2dPTt6j/mj06s8pXSy4dEhov/J/uXdGd+Vlsv/4Q7IUR6
 txNDyei1fOgTO9ZkoA4RCJCjMlYrYI04swGkjtpz5mp/owe8xZZF+VH6FiMEkxiSCG4m
 L3D72kBHG9TlCEknZwgC+tP57hXuuNgnzRvZFtCTsEB7MPlMO3D4djoqTvaiB/LrtqVB
 hXF1LYbd3DzSjDffnOsgO1ZvhB1nfnbtowG6PrIvY+g7/iVAPeFXF7NenOCj1JUAtQMN
 mQp/MwRPwyyKNsNloV9cxVdT5QijNaIHHX+kOARwdzcgbM0ImN8kLFrUHNLJNB/qOcuc
 10ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783440151; x=1784044951;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iCosDLrehq4m5p6p5M008ObV3jYts/9AXn26zWzUnOs=;
 b=f3LNUGbPZa1jUOwy30kE5xaZqW7QzFeYOVUTl8Q+dfUcN4TnfPFRYL4a3aT8Q1Fenv
 bkj1ZkvXTyLXCtfSHfT2XHS+crSJZOyaoXhfySRgX0lhNMygebSczq59Nc+A6E8heb9R
 r3TTZeDmHIj6xleh1TZ3xKp/BnXZwAy3cjjW7PgN+BpNaf5Rit0+hga41GhbKWxphk/d
 25ttGsyAQnpYKjNttM5asV1E4iUv4IQgDVruH3APespcsEsDx7O92njVo+iAZLNkHtl+
 i7HknxIPa7V1zqtnlQrKHZuhvKpFPUwDqaJxyuouYzFEUNEkzNuLFy6roRDtYsc/XWS3
 KPfQ==
X-Gm-Message-State: AOJu0YztXDD2193yJ5TcOYRmwA1zpLzaJOBxchl4EZb07NhAWVBL8ojV
 0fI/hYELxtwO+4sC3uOqI8fEucwnU+hzdiluKUlPLOhlEuGNBcdfka0mz/NN1SEhaYI2q1ZJLAm
 Mx9G1l/VLNDf+F7uDSpkynxnrG8BbLpR4OZxBGX2ojIy263h5KaC+oi/fQvI=
X-Gm-Gg: AfdE7ckOWMfGe/68hb7J7HUJuGUWYPifPElusVTmyzRgCVxwQTomrkEcu8d9/EFsWxd
 /9xK9iMYVVngYjSYnoiiRudueK81N8bIlesM4IDCpcBE1w5x7WP0ItwHOdd/czP3o8oQp1pYWVy
 Wy2jbRoJ3LxUc64wbfrR0fHxzAYu4I4cuQHgMtRar1y3vcnjgqd1z5SNo8ssdoZ8mZxe1fCVLyU
 LcPI+Du6oWOlGIGd9t30pdCJug+gNq/Wk+2dY/aIzjrZbQM0Fs7Tao3BOD70L21gcu8X3MhxJ8a
 nGfnzGPTcZhh0IHW+6li98RBHx4=
X-Received: by 2002:ac2:4652:0:b0:5ad:5814:1b72 with SMTP id
 2adb3069b0e04-5b007c4b442mr1027177e87.34.1783440150916; Tue, 07 Jul 2026
 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260703072721.18c5987a@phoenix.local>
In-Reply-To: <20260703072721.18c5987a@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 7 Jul 2026 12:02:18 -0400
X-Gm-Features: AVVi8CdUjWFpt9yzV8UH5XEM8OuBncS6nbuJMtQZsD26-PeE0XKLY970EyIxI_Q
Message-ID: <CALuQH+UE2kJdfbny0qLSxB+izFSPTQJXVCwDNbUotrcQL4LYhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Stability fixes for GVE
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

>
> Better but fails on 32 bit build during post-merge testing
> DPDK 26.07.0-rc2

Will fix in v3. Is there a way I can test 32-bit compile using
test-meson-builds.sh? It doesn't seem to be covered there by default.
