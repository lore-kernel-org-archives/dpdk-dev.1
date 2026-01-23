Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D315D74EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 15:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BFEF4026F;
	Fri, 23 Jan 2026 16:43:25 +0100 (CET)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) by mails.dpdk.org (Postfix) with ESMTP id 3555340269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 16:43:24 +0100 (CET)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-5ee9fa419f5so488883137.3
 for <dev@dpdk.org>; Fri, 23 Jan 2026 07:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183003; cv=none;
 d=google.com; s=arc-20240605;
 b=i2YNlUOvhc7JAz3I2U9yvIlJ1M91GqLimBqFCOmb3/9f7K+GBsGyt1Frp9xsySLcZX
 mnoC1pIXOS4bEg6mmJ8gF34imiswvjbd9r6BzyrCBrkfTzuZnOphFZUnuY4pSTo+2IlN
 n3rbBXJWvvOOIQXW0GErlKKLbRRT5hu0in28yZer56YJeM+rabQPx/X7Q+qRY6AQERke
 N129MTTlR8/BprewjS/XEZ00oDG72I3r36xYInV8flrDz2OmBYHgHf0YGb8hlU0QM7kW
 YANX/CD2v8gmOzVv7QDflIuo+F/ye5Nf7CWF9abfckHUHC1kCKHMU1xQt8b0JvbYzTEv
 iTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ru0ACRXwWSGuNVC3bKdtz1Mx+3k0BFvqVoVzLJF0F2A=;
 fh=lYK8XMpcdNnFeV6tMw3Y0MzyPZ1Zvvy3xO2rBhfNJso=;
 b=bvc4pbMKgQa4IFO5WAkp4hhZsb0z+w3XD16lJEDha73g4JlrN6jbDpySwqyWyDumPM
 oaLav0w5/svCVXDZtaMh08SeEDYgGwQNarIw7mdssA77CbzwYuwLj9tvofzf/yF7U1VR
 sTEGaPgtpLxcAikuvG/TUPT/T628hXOkMHSsQVOjygKu/AJrP/VjwRBLTNNo64hRHRBw
 8SaTJOBlY5Czx6y46UIcSyW7x/MomdhTpZaGcyvbyTUXzr/RDy0o6TN/cY93uQqSGV14
 Y3aykyP3umpl6Ig4k1wJbFhsnR+ZX1OoJ6wUv9EKz+GvAewOuTgBat8s8tC5Zz3S70bF
 cfEg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769183003; x=1769787803; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ru0ACRXwWSGuNVC3bKdtz1Mx+3k0BFvqVoVzLJF0F2A=;
 b=XBreu9HwBQeS0o9zcBO+cO/xYad9wmZocnX1rvU6qGxSU+yv1u2WoDbd58grsitw/J
 9B8oQjhMIC0+4MTIyObCmJONfw8FfQ37kkoJQOyrd4Nhjwt0ltXK9llVJCCjN2bGDSqS
 Lt/NRicEl8vo8lwwptbmsfX/PfPYRfv28ZNNahhGq766iue5rKKaKKRNAEOpfb+zyiGI
 OH0p9Bt/agFlnTV1aMiy6rqcclIhrvxt6WQeoaKOqPuq4XXis7ZUyXCutLpiZ3i477PM
 daWYBiKAUtw2FmY0S9OkD/tLjl2RrZ/PzZkQ2ktRKMTLlHK1/rRdUrrnNMysCY7rsmMk
 67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183003; x=1769787803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru0ACRXwWSGuNVC3bKdtz1Mx+3k0BFvqVoVzLJF0F2A=;
 b=SXmm/QlAKdjFBr0VyZ9URWjA8egw9RdFEB0kCl+34JjqhGlNY0698Qo8ikYCM9O2rr
 oGcEV66115w2UxwV20sUy1I7mBnVBKIAIN/nHlXBPpxORKFsdraiygCfxBMK2Eo3iVHH
 Bjji9QQSlfT3WFqx2rPkYSZM1YC/fAHVILLwT8XqDH1U0QrBE0nn856mNnlg7tZNArRW
 yXBAtKNhQ8R1+QkzuWWt2viCh9PtN715HsLCntEaBS+2Yv1YyXrf/1RB0vOP3bXoizEx
 zXQc2ZwrK9Gu9opvEEIvJnyDVUjvWoa5TyJ7/yhKM+wiAzpWDwtsuyrOv94rnOHn3iOy
 5ZAg==
X-Gm-Message-State: AOJu0YweK5XouXinkJF1d3jxNM5hU0+IJ9oIQhvQlLpcY4aBfoTA8Y4f
 T22U3XxHIrgeDHvd77sj9U4AE0TJ4gPaQ1pNCHU7leXSWYpFQJHzICVcoIvEL4Ck2Qo78OHgr+6
 A0SPWi1JP8HLsqn4Ae9btXGtm4xxUzszpCMJa
X-Gm-Gg: AZuq6aJ+GsXsQL748qYTRkt6Eaz2h94ayKQ66WzA1mMByqIRmEhVyd+/JytSTlVRA/4
 jQZattOPiUhVXVQ0Poz/i7HLSsMSVU+HYeGHRuqE7jgoueR5XW2jAPdaN1x/BrGtH/INgHH2/Cx
 LeE50FcJPE2tLxv8AuczmyMTKDATpkk923RZQEcsM6Qdp4qyr4V7JNUW3hoWhlGrijznLoxF1vt
 qpFoo1i24esJm/1Kqeq5kOQZtIOUq5KeETGod2Db0b1oA96ufAfaC4tShnzem2HhfBwb7c=
X-Received: by 2002:a05:6102:e07:b0:5ef:b5fc:dd48 with SMTP id
 ada2fe7eead31-5f54b994197mr969054137.9.1769183003398; Fri, 23 Jan 2026
 07:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260117140848.49104c2b@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65678@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65678@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 23 Jan 2026 07:43:12 -0800
X-Gm-Features: AZwV_QgqKTe392B4siipIQB9zv9Hq0NHi4U2Rw7s35hEmEYWvAVa4OmZasj38KU
Message-ID: <CAFn2buD_mG7DHwM2cp5LO5H-w2T5e7_ygk+hptGNwWea1UF9mA@mail.gmail.com>
Subject: Re: [PATCH v15 0/2] net: optimize __rte_raw_cksum
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
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

Awesome! Thanks Morten & Stephen for the review and constructive
feedback, leading to a better result in the end!

I will submit a v16 with 1/2 including "Fixes: 7621d6a8d0bd ("eal: add
and use unaligned integer types")" as requested.
