Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F4C36010
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0D34402F1;
	Wed, 26 Mar 2025 20:20:43 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id D3FD94021F
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:20:42 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2255003f4c6so5741315ad.0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743016842;
 x=1743621642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIQUk15O/C9RIcQvFcTD/tjLbDb1j9kb2Ocsnyt2Ywg=;
 b=mNgdOy20vAe2aTL+WPEqtERaDISj+t2/MXy46S+foVUdMxE+EeHJSd1F2efVZEquDI
 uar05nt4GiEFIFrxfYikVKLDjUtmXwEC4UbYD0TwtZCEZIqhvOc0DjH+dtHLl9ty7MHd
 J8jNJz5KXjmY1TNNRorr9wQdfdQazvXWClJRe+r/3+7OPtSoQdsYtc+Lo9pocqV0w1ej
 5Unx6m2g1gSpIxzOrutdHo/+rxoMUA88JYj5wRdszGp5MoiASBy6ZW7Bvs5s5k5Bx8UZ
 GFLKBiXqNyVC06gmM7FKZqylVe3jMGYtFQjv63AfYEVSP8gfczpzl4zl9UfWSvJ4mgUD
 lWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743016842; x=1743621642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIQUk15O/C9RIcQvFcTD/tjLbDb1j9kb2Ocsnyt2Ywg=;
 b=wVa8mgpOUWcCxfpoROxInzX6GIiNXnjxZ2+td/vOWSEkLJII9m66q0HQH+g0JfGGQt
 ildBljtmw6fDXOkE2qt/AC8kuy5mPjaWpjuccVbVBWQ7+Gq9pkbRN0RHakcnvF16qkhO
 h5MI1Y/USW6hKHu53g2xNdbF5wDU3r1Uw0AcuP2lD5xgs96WoflMpiakH8EUw4HNahAB
 GDWfoLn2/57mTvECOGu8VV2hIid/Qp9rMlYcBYolzCwhtfHqcMEHbJ7upV/2STvGOls4
 413tFgbVweeDf1Ac47oelDZEl7gksihuJmjCBIW4A0BCLrRKYXJi0MMeGVszBsJY9S+R
 rMJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPUb2AOL3nbaVuyiso4fQ08HdGiDRwU6BEJcKV8qTaHsShB3Qgi/a+7CWKiNIqHWNMDcg=@dpdk.org
X-Gm-Message-State: AOJu0Yzp/R4xXMpp/NbF3y1V+HA553jqf6Zyb6QojLbhPvCLkqtLwP9V
 o4sKt7WmXqx5LYMrYc8GwMQZFX4eE5uwhuZTPNbv/wFm//lDYxujoA+ZFbmULhk=
X-Gm-Gg: ASbGncv7RwP4ybou+qlgp2yY7Zjn9W83aoJIAFlCR+m1PlKsoXJpqcApMJmgM8jQvkj
 QG7iiu1y5/4QiC1tGhyAav4I8wlIqtp3zKOeLWFHsazvPUB/AAMrxO3NreSeFYFzBD1ejoR6/el
 Q/mihAaOHOscFqtWGGI+iVqwjNbE2AqZOdtvge/xH07KbHugLB9rsMBYtIQdGsmnds3pMX6m8/9
 hfVZvzE0bdzKdSNFEahls6c/lvy0zWGIOIbzIeJfSfFhs0USmvZstyXI89tiY9GDEbrXiecurj9
 qpcUkzgQRS4eN0M5GEtYH0UnWDE+snzrbXPPx5HW+ut6xOwOrNfJENyXN+NaWRuSidN013aVWu1
 GZVoss1MKYERVbyce/s72
X-Google-Smtp-Source: AGHT+IFltztHLL92Kl/+3vEBY4yj9qw3np6uqzpU2tyqKZ4Tjqp06NJBYk2RrQIQ54Ps3N0C6BPFMw==
X-Received: by 2002:a17:902:ecd0:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-228048521e8mr11518485ad.15.1743016841851; 
 Wed, 26 Mar 2025 12:20:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3a2b5sm113817055ad.50.2025.03.26.12.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 12:20:41 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:20:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>,
 <techboard@dpdk.org>
Subject: Re: [RFC PATCH] build: reduce use of AVX compiler flags
Message-ID: <20250326122036.6cc7c02e@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 26 Mar 2025 19:06:58 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 26 March 2025 17.22
> >=20
> > On Tue, Mar 25, 2025 at 05:22:15PM +0000, Bruce Richardson wrote: =20
> > > When doing a build for a target that already has the instruction sets
> > > for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > > skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
> > > the default flags produce the desired output, just use them =20
> > unmodified. =20
> > >
> > > Depends-on: series-34915 ("remove component-specific logic for AVX =20
> > builds") =20
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >
> > > This patchset depends on the previous AVX rework. However, sending it
> > > separately as a new RFC because it effectively increases the minimum
> > > compiler versions needed for x86 builds - from GCC 5 to 6, and
> > > Clang 3.6 to 3.9.
> > >
> > > For now, I've just documented that as an additional note in the GSG =
=20
> > that =20
> > > these versions are recommended, but it would be simpler if we could =
=20
> > just =20
> > > set them as the required minimum baseline (at least in the docs).
> > >
> > > Feedback on these compiler version requirements welcome.
> > > =20
> >=20
> > +techboard
> >=20
> > Ping for a little bit of feedback for this. Are we ok to bump the
> > minimum
> > compiler versions as described above, or will I continue with the
> > approach
> > in this RFC of keeping the minimum and just recommending the higher
> > versions for x86 platforms?
> >=20
> > For reference GCC 6.1 was released April 2016[1], and, Clang 3.9 was
> > released Sept 2016[2]
> >=20
> > /Bruce
> >=20
> > [1] https://gcc.gnu.org/gcc-6/
> > [2] https://releases.llvm.org/ =20
>=20
> Considering GCC versions shipped with RHEL [3]...
> We kind of support RHEL 7, but we already require a newer compiler (GCC 5=
) than shipped with RHEL 7 (GCC 4.8).
> RHEL 8 ships with GCC 8, which was released in May 2018 [4]. Maybe we can=
 jump to GCC 8?
>=20
> BTW, we should also apply the same principle I argued [5] should apply fo=
r upgrading the Kernel requirements: There should be a need for specific fe=
ature or similar - which there is with your patch - and the details should =
be mentioned in the release notes.
>=20
> [3]: https://access.redhat.com/solutions/19458
> [4]: https://gcc.gnu.org/gcc-8/
> [5]: https://inbox.dpdk.org/dev/CAMEVEZutf4sJ=3DEQFONw_bJW0tGTWqTbF_Tk_y3=
8qzBLccco46Q@mail.gmail.com/T/#me7c8f1dbe4331ccf232d43512d6ddb51458c568a
>=20

RHEL 7 reached end of life on June 30, 2024.
DPDK need no longer support it on future versions.

