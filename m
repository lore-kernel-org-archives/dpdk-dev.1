Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C810CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 07:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E748E402BD;
	Mon, 11 May 2026 09:30:04 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id DBCE5402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 09:30:03 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8ef5776530bso380512785a.0
 for <dev@dpdk.org>; Mon, 11 May 2026 00:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778484603; cv=none;
 d=google.com; s=arc-20240605;
 b=kEDaYa2V/uL/fVUEjUR9TXC/I1XhtpqOe65CTzlF2xCmaOBMB9UBSUnc0oVMQgPApC
 az2BIX8mMANPMx73IprD+2cL8HnCUXvcqPuSSHgVhUPy/N9JH4ZFhTz8E4IKqrFdXvlD
 gGHKVZ15R2kR5VH9BfjZN7vDuog742dpczaWShGc7lj8yLOxvLTfJQv+mHtLKn13hLUA
 i2iBUZ5Ra5tMwKlJY02YTi/pDQP2P9OLsE1/jXYNBYNWmYVSxmazvTOlTkBj7SdqXQED
 SdNCApxRJ7Bcc0Qy49Dyf6a3gVCAWFU97DXVS7DE1p7PhhCc8ZHSDJdsaKb2L9NE4JXq
 i54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=cnqOm3Vco6czLP5MhSkBKVc9Nlf1vT/qKTGBt2x9b8s=;
 fh=VBo/efJlCr7WFJty9sq8pv3qfbHwgBTP9kWfbc2ycZM=;
 b=IoAaqFdCbOZ4KBZZ7Jjoa6M25zoqpuArpKa0FUP0tfvJ0lntyyVFIRRmzhEI8PuVUp
 NGuJP8sg4TCSCx3NZSEoHtpvr64FJBkH9884b6XMYiWlNtlt2urkScf169tzdEEKoj+7
 Kvl8e7zHweKwArbA2dZD+kS1Kjt5phdEVbMJrfM9RlLqiisW3HdZ5Uu3jHYZyU7TomCw
 YgDQAZy4g9WC8Cpt5lIuVPs4jcFWm5K77MwRuCAXzifEh6Pnx4ioct+V39wYa94yNbr4
 W62P+FuoexQCelldyACx4l5Z/ZLT2ZYE/pfEjIB5lKOOKDG85cfbVgeoyW4F/QbmwCvo
 RiVQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778484603; x=1779089403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cnqOm3Vco6czLP5MhSkBKVc9Nlf1vT/qKTGBt2x9b8s=;
 b=JZ2Be4sxsCQBype6nmveVAvrkTwzP/pcl3WV4ZhKuyLZhfB0vUD6WM83ltUspXLtOb
 3xd2gg7hNT3eljWZGA88Ty1Ps9z14gTgrtthaiV42SB1djxCjBKEF9UP6mj6J0TyTV0F
 eUpbjrLl9J9rZr+VwG0Xlk8enzaT1U4LqfzfEm4jIUifUtJGPLn+kOb2pKLbVVogAjlq
 6zzRX9QihRRl1b67fhsUDbwceME9a8l/9rYKcs8UMYKblAEkiFiSREoMRW8/jmEA5FJi
 PQLYq02FuW4SxsIy96RYgu9tqaV06KMQfyn4fHRAnvT0tfOAgaLes/GFERZela97e9ok
 iR+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H11PkCBbMozJqiw4AEU0sl2Kr4kSEWX1bdZhHSNZHFHMmGXDGqUElZDhhHjkCPk5xONE=@dpdk.org
X-Gm-Message-State: AOJu0YzsVROefqaHAmRi/fBWdmjYBruQLWAAtmGVfKuy24U1urE0tngZ
 KEernkQa9AQ/lC/1CrVP96JbtfQ+wkWE9OB2sE7nqY2gj+X53e5S/QD+Nbn1ipBJMgRJgYnpNiC
 RP7bVNIQSnSbcMjHFPdoODE9B7uHgkx6FoJ3x
X-Gm-Gg: Acq92OFKjLi6TL9msvdJZbekc8sLvuLCHzFm6fR4AwR1wb84MSGqbrFUZM/schx1XPE
 1MroXeK1gDM7aujJhyMB7LwozNkBasXCCN0f1879P0666BMZKubxHJQDWN7tCrli5xHzP0B9ObN
 emLA0I6oqHvvqEoKVsOgxBlVwm1axksRL8xHIOrrEZnpZfsifUXlvCaN0yVQvuAyAgRAT6ERUBP
 VouX1DB3Yax3q0NA/0AixicMmS0XLyIDePFl3xQ519PmN9GfXt7aS1a/Ej9CZZhy0pkJKPw9zwI
 2Y6htQg0aeDOvLU=
X-Received: by 2002:a05:620a:4720:b0:8fb:1acb:c907 with SMTP id
 af79cd13be357-9090dfffd04mr1301694985a.12.1778484603116; Mon, 11 May 2026
 00:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260507120253.3eec853a@phoenix.local>
In-Reply-To: <20260507120253.3eec853a@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 11 May 2026 09:29:51 +0200
X-Gm-Features: AVHnY4LQsl6UrKLPoyO-66TsNSSlqY3eA-LB5NFggw5MyzBwakQaJkpnYK3Os1g
Message-ID: <CAHHRULWpoQvnXmB=G=gjEM6AU8ATnMvpb-xmF8=1O4FJ9xgmEg@mail.gmail.com>
Subject: Re: [RFC 0/3] fib: tbl8 reservation drift reproducer and proposed fix
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Stephen,

On Thu, May 7, 2026 at 9:03=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu,  7 May 2026 11:50:40 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > Asymmetric ADD/DEL sequences in FIB6 trie (a covering parent
> > removed between the ADD and DEL of a longer prefix) eventually
> > make ADD fail with -ENOSPC even when the tbl8 pool is empty.
> >
> > Patch 2/3 is a small reproducer.
> >
> > Root cause: rsvd_tbl8s is updated by depth_diff recomputed from
> > the current RIB, so increments at ADD and decrements at DEL do
> > not cancel when the RIB state changes in between. The counter
> > drifts and wraps to UINT32_MAX.
> >
> > The simplest fix I could find (1/3, 3/3) is to drop rsvd_tbl8s
> > and use the pool counters already maintained by alloc/free:
> > tbl8_pool_pos in trie, cur_tbl8s in dir24_8. The DQ reclaim
> > inside tbl8_alloc() is moved into the pre-check.
> >
> > I am not sure I understood the original intent of keeping
> > rsvd_tbl8s separate from the pool counters. In dir24_8 the two
> > mirror each other 1:1 and rsvd_tbl8s looks redundant; in trie,
> > depth_diff gives it a worst-case-reservation flavor but the
> > recomputation from the RIB is exactly what makes it drift. If
> > there was a deliberate reason, please point it out.
> >
> > Patch 3/3 is a no-op cleanup that aligns dir24_8 with the trie
> > pattern.
> >
> > Maxime Leroy (3):
> >   fib6: fix tbl8 reservation drift in trie
> >   test/fib6: add reproducer for tbl8 reservation drift
> >   fib: drop redundant tbl8 reservation counter
> >
> >  app/test/test_fib6.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
> >  lib/fib/dir24_8.c    | 31 ++++++-----------
> >  lib/fib/dir24_8.h    |  1 -
> >  lib/fib/trie.c       | 23 ++++++------
> >  lib/fib/trie.h       |  3 +-
> >  5 files changed, 104 insertions(+), 37 deletions(-)
> >
>
> Used  this a test case for multiple AI reviewers.
> Most reported false positives in various places.
> But the winner was Claude web (or desktop) with Opus 4.7 extended.
> It saw:
>
> Patch 3 - fib: drop redundant tbl8 reservation counter
> Warning: The commit message frames this as removing a "redundant" counter=
 and claims "Behavior is unchanged for non-DQ modes," but dir24_8 has the s=
ame rsvd_tbl8s drift bug that patch 1/3 fixes for trie6 =E2=80=94 this patc=
h silently fixes it as well.
> Trace (no RCU, depth-1 mode):
> ADD /28 A (no /24 cover):
> - tmp =3D=3D NULL, pre-check passes
> - install_to_fib allocates 1 tbl8 -> cur_tbl8s =3D 1
> - post-add hook: tmp =3D=3D NULL -> rsvd_tbl8s++ =3D 1
> ADD /24 B covering A:
> - depth =3D=3D 24, no rsvd_tbl8s update
> - tbl8 entries rewritten, no alloc/free
> - state: rsvd_tbl8s =3D 1, cur_tbl8s =3D 1
> DEL /28 A (with /24 cover B):
> - modify_fib installs B's nh over A's range
> - tbl8 becomes uniform -> tbl8_recycle() -> cur_tbl8s =3D 0
> - post-del check: tmp !=3D NULL (B is the cover) -> rsvd_tbl8s NOT decrem=
ented
> - state: rsvd_tbl8s =3D 1, cur_tbl8s =3D 0  (diverged)
> DEL /24 B:
> - depth =3D=3D 24, no rsvd_tbl8s update
> - final: rsvd_tbl8s =3D 1, cur_tbl8s =3D 0
> Each repetition leaks +1 into rsvd_tbl8s with no actual tbl8 in use. Over=
 enough cycles, rsvd_tbl8s reaches number_tbl8s and the pre-check rejects v=
alid /25-/32 ADDs even though the pool is empty. This is the same class of =
bug as the IPv6 case, just with smaller per-cycle drift.
> The patch should carry:
> Fixes: <commit that introduced rsvd_tbl8s in dir24_8>
> Cc: stable@dpdk.org

Thanks for the AI review. It makes senses. I will fix it for the V1.
