Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696DCAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A02214064E;
	Tue, 16 Sep 2025 15:54:28 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 99EF64042C
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:54:27 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-261682fdfceso27296935ad.1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758030866; x=1758635666; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gLsEZKTGJ9tDDZAxakZu2WIo4blsnEBR9V6Ja48vJdE=;
 b=VJcb94pOD9jhqRZtmJa9ywL9oyIkXmXbaDtREHf12rIH9lMVlVWo1C0Da4H/VGA5D4
 88jemzy5fDyHVXLWmdeuf+DN9W7J2G2wkoul2EGg1fBi3Hc3Crj2LbJyUjMRad0gLKqv
 WFnhzqYWfQ+63vrQhR0nT+jJmhfHgqDjPnIxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030866; x=1758635666;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLsEZKTGJ9tDDZAxakZu2WIo4blsnEBR9V6Ja48vJdE=;
 b=OeFG2lzxBK9UzDBQGg7LFVBrZhU5P7VZvdV+NmH9nTMZDSTMwtLGTTPLxx8OdJDX5w
 KE3z2bqy6bZ0FSMsbmg2u74lIR6+wHzZG64eAC0k1+wOchw8eOunnEMVwhpncfrznAeg
 UwMlgthYERq8B/OSM7YqwtDullpjrmcS3hkFJZBqPTRC6yNL/TtJePF5Ycr0LKmXkw7J
 tulBeZgIKa5f1vhOYBAiE6HW3XeR4OCqbYxP9W8E3lE177wBP2K754o9KsJqFGtFTUJz
 VIF1HnjDGZ7PwhSFLPRgBXIfOHeTjc58COSr/t7fh5rH01gW6zqhkDVyfn339zxZrYkU
 0hlQ==
X-Gm-Message-State: AOJu0Yxf28nAUUD61hLnrX/h0aVuZHxzcAgAmJoSl1k/d6m2k19/oeRx
 m0iQNegoGmFZwIlo9oZFZylL8s3VqSknYFMvNWgjk/rUNLJU+P2KEmNwFNq0tZqVvvdggjOTwJ2
 3gx203CnL1EK6VfSfWSKIfmkKjvzwH0gcFN7nNNF45cWY96pt37/mlyU=
X-Gm-Gg: ASbGncux8X7FXZS196HatMw1S8WOool7zxTu6JKzTVbDs7nM0UhEA1oqTk1yKQSAt+G
 h5/Z1JUquVLnv5NZoSOOSVk/jGlnYuLliAKGZWLs2f6PYZo19XO1jCqMw+jZyptvojMobc36013
 xwFLOpe7nA+N7uw1f3yW8ureMR3xmiOzOsi2sck3DXi7i2n+GDjJkFdFX08HAkYN6cqvPV7cKfj
 LT6EjPmNwtjTzc7v7GPfT9uQw2kJ9UQnaJeSbncg/xoan1eS/4=
X-Google-Smtp-Source: AGHT+IGBmLLPHl2TRvWgdlZGDjukrb73EZA8pi8RVXMVBd6osVfWMADPMgsS7Fxf04BVwyfweSaspqmWIEZC3KzDEW8=
X-Received: by 2002:a17:902:cecc:b0:267:a1d5:7372 with SMTP id
 d9443c01a7336-267d151fba1mr34623265ad.4.1758030866354; Tue, 16 Sep 2025
 06:54:26 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:47:24 -0400
X-Gm-Features: AS18NWDYPKEm4euiP4pRv5Jwa1UF-LkYSSUgllcC7ISIzGu-lmrcWdICb08G7fY
Message-ID: <CAJvnSUD-p5A71L13VWH6XD3N5gMmO1R4+gKbTpZXXd55v92jog@mail.gmail.com>
Subject: DTS WG Meeting Minutes - August 28, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004b2b5c063eeb75da"
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

--0000000000004b2b5c063eeb75da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

####################################################################
August 28, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey
* Paul Szczepanek
* Thomas Wilks

####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* The new DTS guide videos will be on the dpdk.org youtube soon

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* TG Driver Bind series:
   * Binding Worked fine except for mellanox where is_bound_for_dpdk logic
resulted in unexpected behavior since kernel driver is the same as DPDK
driver (mlx5_core)
* RSS:
   * Some testcase changes requested, but overall the implementation is
working
   * Someone will be taking this series over:
      * Paul will take over this testsuite
   * Proposed extension of the existing testcase #2 from below, splits it
into 3 testcases. Left side is hash, right size is queue.
      * Testcase #1:
         * 0 -> 1
         * 1 -> 2
         * 2 -> 3
         * 3 -> 4
      * Testcase #2:
         * 0 -> 0
         * 1 -> 1
         * 2 -> 1
         * 3 -> 1
      * Testcase #3:
         * 0 -> 1
         * 1 -> 1
         * 2 -> 1
         * 3 -> 1
   * For test_reta_key_reta_queues, strange behavior for mellanox (creates
a reta of 2, then 512, then 16)
* Mbuf fast release testcase:
   * Morten has drafted a required update to the testplan. Patrick will
send a new version in new DTS. https://bugs.dpdk.org/show_bug.cgi?id=3D1769
   * The testcase works, but we need to add in capability checks for
tx_offloads and mbuf_fast_free tx_offload
* Virtio:
   * Per Maxime=E2=80=99s advice, we will run a vhost backend with a virtio=
_user
frontend (with no VM) like so:
https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
* DTS API:
   * Should be posted by the end of the week
* A couple patches have been merged:
   * Still needs to be merged:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35972
   *
https://patchwork.dpdk.org/project/dpdk/patch/20250820151850.484576-1-abail=
ey@iol.unh.edu/
      * Patrick to do a final review before merging

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* Patrick to review the bugzilla list and prune anything:
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&list_id=3D9=
622

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next meeting is September 4

--0000000000004b2b5c063eeb75da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div>########################=
############################################<br>August 28, 2025<br>Attendee=
s<br>* Patrick Robb<br>* Luca Vizzarro<br>* Andrew Bailey<br>* Paul Szczepa=
nek<br>* Thomas Wilks<br><br>##############################################=
######################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* The new DTS guide video=
s will be on the <a href=3D"http://dpdk.org">dpdk.org</a> youtube soon<br><=
br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discu=
ssions<br>* TG Driver Bind series:<br>=C2=A0 =C2=A0* Binding Worked fine ex=
cept for mellanox where is_bound_for_dpdk logic resulted in unexpected beha=
vior since kernel driver is the same as DPDK driver (mlx5_core) <br>* RSS:<=
br>=C2=A0 =C2=A0* Some testcase changes requested, but overall the implemen=
tation is working<br>=C2=A0 =C2=A0* Someone will be taking this series over=
:<br>=C2=A0 =C2=A0 =C2=A0 * Paul will take over this testsuite<br>=C2=A0 =
=C2=A0* Proposed extension of the existing testcase #2 from below, splits i=
t into 3 testcases. Left side is hash, right size is queue.<br>=C2=A0 =C2=
=A0 =C2=A0 * Testcase #1:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 0 -&gt; 1<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1 -&gt; 2<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* 2 -&gt; 3<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3 -&gt; 4<b=
r>=C2=A0 =C2=A0 =C2=A0 * Testcase #2:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* 0 -&gt; 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1 -&gt; 1<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* 2 -&gt; 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
3 -&gt; 1<br>=C2=A0 =C2=A0 =C2=A0 * Testcase #3:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* 0 -&gt; 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1 -&gt; 1<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 2 -&gt; 1<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* 3 -&gt; 1<br>=C2=A0 =C2=A0* For test_reta_key_reta_queues, stra=
nge behavior for mellanox (creates a reta of 2, then 512, then 16)<br>* Mbu=
f fast release testcase: =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0* Mort=
en has drafted a required update to the testplan. Patrick will send a new v=
ersion in new DTS. <a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1769"=
>https://bugs.dpdk.org/show_bug.cgi?id=3D1769</a><br>=C2=A0 =C2=A0* The tes=
tcase works, but we need to add in capability checks for tx_offloads and mb=
uf_fast_free tx_offload<br>* Virtio:<br>=C2=A0 =C2=A0* Per Maxime=E2=80=99s=
 advice, we will run a vhost backend with a virtio_user frontend (with no V=
M) like so: <a href=3D"https://doc.dpdk.org/guides/howto/virtio_user_as_exc=
eption_path.html">https://doc.dpdk.org/guides/howto/virtio_user_as_exceptio=
n_path.html</a><br>* DTS API:<br>=C2=A0 =C2=A0* Should be posted by the end=
 of the week<br>* A couple patches have been merged:<br>=C2=A0 =C2=A0* Stil=
l needs to be merged: <a href=3D"https://patchwork.dpdk.org/project/dpdk/li=
st/?series=3D35972">https://patchwork.dpdk.org/project/dpdk/list/?series=3D=
35972</a><br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpdk.org/project/d=
pdk/patch/20250820151850.484576-1-abailey@iol.unh.edu/">https://patchwork.d=
pdk.org/project/dpdk/patch/20250820151850.484576-1-abailey@iol.unh.edu/</a>=
<br>=C2=A0 =C2=A0 =C2=A0 * Patrick to do a final review before merging<br>=
=C2=A0 =C2=A0 =C2=A0 <br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>Bugzilla discussions<br>* Patrick to review the bugzilla list =
and prune anything: <a href=3D"https://bugs.dpdk.org/buglist.cgi?quicksearc=
h=3Dcomponent%3Adts&amp;list_id=3D9622">https://bugs.dpdk.org/buglist.cgi?q=
uicksearch=3Dcomponent%3Adts&amp;list_id=3D9622</a><br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next =
meeting is September 4</div></div>

--0000000000004b2b5c063eeb75da--
