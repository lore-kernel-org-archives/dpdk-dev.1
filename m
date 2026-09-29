Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75EACA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFF840E36;
	Tue, 29 Sep 2026 15:42:13 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id C738A4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:42:11 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747eb79f7so18952325ad.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790689331;
 x=1791294131; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gb0xXD5HQJ7EWH6/lH1A3uLCev6TlRqVxt7i6xuZh3Y=;
 b=V2ZHR1/enBuqQ2SVJ3+PEGuS4EeDmkxqC2DYB2mXDB7e8seFsB5d1UXYEicgCjOfx2
 l2YPompHZnQP8xdZCY2U4i1d9jo9klfN/DU+qql/T20YpyFpSBnGQzAi088waZkDoSgm
 xiFnAVr/39Eq/1S8tEclPm/Gtual+463/pf7oM/9/rer1LUA1xEOVzPw9gGgTl9rqxhQ
 +8+2rYRvi5WBccieFIUarKKTR0ZWP2pP10d/1r3siXTTZLCbgDxQmX1Eom/N3xOlQ0+E
 saCQjeHGVC5WUyxtjq9zB71Oc/g6dtBMJz2FB2/pI7jNfAkMJOEfWt4t7zja2u2moJqU
 ngWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689331; x=1791294131;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gb0xXD5HQJ7EWH6/lH1A3uLCev6TlRqVxt7i6xuZh3Y=;
 b=k0QjiVRRz+IeCw/Z8fdYGVd0q5RBtc6f3oxF6kDxTgmDQnreWBkR/6NfaHmcqEAKTl
 fk7rsoUMGC8ElIsQZlTb+DKY+k0y/5hTSpGEbJVLC8m2Jo3VLwdA+mo8qXRiNFCHaL7z
 2EZ5DFht6wnfLccyWvTGsxw3CEOedyyo+FgkG4jhOBV7s7gjnCsh1LyDAlCTLSgcqNHB
 zB/Bs2HwakGHkz9O+s+qpC6n3P6hcxW2druy+6i9o7ezwqXPJI1NPa6TUcUFaERo3TUR
 0c/n82uoy84M1Ff21mcN/mVd+HOwB/cQ34mJmMLokZTc8cEkJBJ0pbChDNA7n+L2aK3M
 pVAg==
X-Gm-Message-State: AFq9FYL+sj4d9xkpaK3kqTtFCZN/PsOypCcIL4C5ew+Woe216LKsr2rN
 kK/gVfnb8Fv5gXmn3dYl9PwaE533yaFNVB6F/OBfD8yDzlvpWxoDTRj2XFuQIjxIz8s=
X-Gm-Gg: AYBFou3IabZQa7SZTgIUBHbRyegPzSUcYztc80h2wTGZztHjYoeAsGrbhpeDctM3Bd2
 fHkS79jeDLn9kkolB0xEbNQH4+uSrf/RVPNFbGKzVpicCqWlbD3p27Kw1iG0LFnkxWqnv+/HCKC
 JeTFpzbhFVhCgzx6j4ZyGzwAjBIahpgcEGNlz4eWcxKl00ZD4z913RIDn3UR0Fgs7Yue6EW0EMZ
 VHBF7SP4kw1GD0ybaPLSLD0cCEAv8pTDm5nLRxL3hVUCY7UaTAvLgR763eOqn8mPioZJR5fPMKK
 sXRt28o37aO+2nj7vIa68jXgEfS+GryeIizQ4u7V3R0nntZRJtvNOWXJEK/EDMnqWxO7rOEHKsi
 9lCzGZmHrmpIgF6XpFMYQwt8XZBe/dQR7RCxrLPXl1gw/j7Zc2Alo9/XPqgx25UwDyX6v99/G6z
 2zzbkJZf/LbP6b0Cv7BvMienPORkryQhsE178BkFsD3IjzzBz1KlZp00zDafrgWfzSkTd495ikv
 Ax8lc/aiFfQNIsrymDJfi34WTN+R/45+pYUCDUy
X-Received: by 2002:a17:902:f544:b0:2df:5967:8eb4 with SMTP id
 d9443c01a7336-2df7deb8dacmr129946375ad.41.1790689330906; 
 Tue, 29 Sep 2026 06:42:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2d4c56efasm4468585ad.18.2026.09.29.06.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:42:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 06:42:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Thomas
 Monjalon <thomas@monjalon.net>, Ravi Kerur <rkerur@brocade.com>
Subject: Re: [PATCH v2] eal: fail initialization if TSC frequency is zero
Message-ID: <20260929064208.6c7453bb@phoenix.local>
In-Reply-To: <art5SCrwPVJ8JkKQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260927195440.89193-1-stephen@networkplumber.org>
 <20260928231637.733450-1-stephen@networkplumber.org>
 <art5SCrwPVJ8JkKQ@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 29 Sep 2026 09:39:36 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Mon, Sep 28, 2026 at 04:15:58PM -0700, Stephen Hemminger wrote:
> > Many parts of DPDK will fail with divide by zero and
> > other errors if the initialization logic ever TSC hz was ever
> > determined to be zero. This might happen on a broken get_tsc_freq_arch()
> > or bad emulation in QEMU.
> > 
> > If TSC hz is zero, log the error and propagate back to
> > fail rte_eal_init().
> > 
> > This fix doesn't need to go to stable since it is a purely
> > theoretical problem; we aren't getting divide by zero reports
> > from users.
> >   
> 
> How was this discovered? Is there a coverity issue id, or was it just AI
> discovered?

It was part of review of pcapng timestamp calculation.
Kind of funny, AI spotted overflow (which I verified) in the code which
it had previously helped write.  Then it was asking it self,
"what if TSC was 0". I didn't see how this could happen unless QEMU
had some broken CPU emulation.

To me it seemed best to fail fast and die in a safer manner.


