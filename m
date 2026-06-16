Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C9CD98E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 14:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79BC140289;
	Tue, 16 Jun 2026 16:28:31 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 96FDF4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:28:29 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so3222492eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781620108;
 x=1782224908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdUn+E6jJdpe+pez5+HnW2MVodBqRsnPNRglp3DIvQQ=;
 b=QmywveQpQfONNBOThzrgWUFsAJteTaa2M2XesCW26y0LVXYPbZZtRreJgbnfZ5XKBR
 QBdQyOKZn00Lxci3POsB7328uJSD/1kRDwUu+6LYYHSOZxf48tPYc8dPHfdQH9u2IHrt
 5Jz/0k7hszo73H6ypORFn+wrAHAeybhhM2WYdNRmGasl7wfyiI/mUG6dR4tbi6k1QeWJ
 hviGclfMGIW3GXT+23xS0mBE451OgOPoitk4Oipd+Rsg4FwPa3n5Bq7lpR8Ln1JtCj/3
 l629NWvSnL6FoHc4UUf5dm+IY0Ctewr7XPIiUqueM+60/fdjBc11zCTtESdx4bkgazq9
 OsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620108; x=1782224908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BdUn+E6jJdpe+pez5+HnW2MVodBqRsnPNRglp3DIvQQ=;
 b=kK+KNPSIHlwEKygKeEcTVf8Cf/eBKy2OlNrYz5zirpBIKwC+LJFOvPwkC+E2qm9aQC
 8ZwzC1RPcjiQ0lFUCKqU6RbSdexo7SF3yIX08Wc7+AwVnJrdIAuYRc17mZpc+tiWmx4p
 4VRNy5NmmQyrklB5kDKUjvcBP+eymevvSW3TUvZmXWahv2bMvr9b8uHJ8Gquug/oEtEI
 Tv4OqmTCNMZCoz/zkWi7m/4AUOXs2xU/vnyWTIiqf2FSiN6RBNetMhAxrFF4J66scVIf
 tC8qmb3I2luIEkgwAo4pQcxTdHeKJ6DHpTvgMZ99y9HCTqrKN5Sf52stKtE/hTH3cWhu
 QPHA==
X-Gm-Message-State: AOJu0YxKaA9SDTZPooyOJUmF4kHEbdMMKWV6ZlbAru2/atpDX+RDO1YR
 npowIG4fT/Nrj77ndIqt+5lPe/ndxezBN7FCz6TxwEjk2dXqIhoWOcYHU7ysz5/sMX8=
X-Gm-Gg: Acq92OHOdcKvqa4k3Wy7qA02xLKWNTpgisOOO28yWWJfZnqXxOLDdHXRO3nCZ6JHKfI
 Wk+uvnHBcXnOTXA+2t1Vppc39dw/cX9ZfAP+UtGIYLWg8h5oZ6JmfprNF2BGzQTHdDFlQPw6IKQ
 6vHErNKZWrSyjeaFNJ2O0/bMszc9HoMVHHpHacXXy2QBrOLqZxtEcubve3Uv8Ub+9ovsmBKfzdB
 huH/4AMkweRzuHqTJ8RuwLD7Z5myxu/wyd9O1jVYLubTNybfTr6Qc1+aYZQCNxHmQXMIxhG4Hff
 GvhfEcc4zWEcIxPXZ0GaZ21c+QavVhw8OVN64BpZ6eAnCOihxObdh4d9NBUvs+6pSnzQE9fEaHG
 OxfUiuuaDUM8gZCdOHzsQoh9FnElipVP0Gwu28469XCdOVeQ/NM+Sea9++Wv42B+nn5aTXxXxEP
 jcISNspG6vD2UlUijcDaKJshf2ZIM/Xh9T9pyit5olbzjD+yXe7TsUDzBabeQZr/SERLgSxZUqS
 Pk=
X-Received: by 2002:a05:7300:2305:b0:304:cd0d:9ea5 with SMTP id
 5a478bee46e88-30ba334cbc6mr2410249eec.7.1781620108535; 
 Tue, 16 Jun 2026 07:28:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e4898c0sm19813613eec.3.2026.06.16.07.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:28:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:28:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 0/4] alternative capture mechanism
Message-ID: <20260616072825.6b464f84@phoenix.local>
In-Reply-To: <ajFDjhDc5hXhE8km@bricha3-mobl1.ger.corp.intel.com>
References: <20260609210540.768074-1-stephen@networkplumber.org>
 <ajFDjhDc5hXhE8km@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 16 Jun 2026 13:37:34 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Jun 09, 2026 at 02:02:01PM -0700, Stephen Hemminger wrote:
> > This is an RFC for an alternative way to capture packets from a DPDK
> > application. I did brief demo of similar mechanism at DPDK summit but
> > this is more complete. Capture runs in the primary process and is driven
> > entirely over telemetry; no secondary process is involved.
> > 
> > A client asks the application to start capturing and passes it a file
> > descriptor to write to. The application writes pcapng to that descriptor.
> > A Wireshark extcap script is the intended front end, but the control path
> > is just telemetry and the output is just a pipe, so other front ends are
> > possible.
> > 
> >   1/4  telemetry: let a command receive file descriptors from the client
> >   2/4  capture: the library
> >   3/4  test: functional test
> >   4/4  app: the Wireshark extcap script and its documentation
> > 
> > Setup and usage are in doc/guides/tools/wireshark_extcap.rst.
> > 
> > Primary process only for now; secondary-process capture is possible as
> > follow-on. Posting as RFC to get feedback on the approach.
> > 
> > The extcap script is dual licensed (BSD-3-Clause OR GPL-2.0-or-later) as
> > it may be more useful in the Wireshark tree.
> >   
> 
> One concern I have though - does this cause system-calls to be made in the
> fast-path because we are writting to a passed in FD? For performance
> reasons, would it not be better to use a memory buffer for this, thereby
> avoiding syscalls? For example, rather than passing in an FD to telemetry,
> we could pass in a key to be passed to shmget (going old-school!), or
> name parameter for shm_open. Thereafter with the memory buffer we can use a
> circular ring or similar to pass the data from app to client.
> 
> /Bruce

The system calls are contained inside the thread spawned when capture starts.
The flow is:
         callback -> ring -> capture thread -> FIFO -> wireshark
