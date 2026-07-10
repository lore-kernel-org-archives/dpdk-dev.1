Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF19C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 02:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF70F4026A;
	Fri, 10 Jul 2026 04:29:58 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 43C9740268
 for <dev@dpdk.org>; Fri, 10 Jul 2026 04:29:57 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47640541585so202762f8f.1
 for <dev@dpdk.org>; Thu, 09 Jul 2026 19:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783650597; cv=none;
 d=google.com; s=arc-20260327;
 b=LclxJNeZXl8uECw/1TcB0C+AeDQ6BMVaj4Jd9DJhR06Y2io3WkR8DIKL26FZhPlhT8
 VT4huyh2LDAeWv/zW1KxVt92SINm8Ko2q1em+/ZrJ6xAecsSFcVj++/lTfmNZOWh3QXs
 6Rzv/7aMGDGvKZs6bzY2HGevzz6zOoCpeR9LTLwB1IlWpyvBFNwMCJov4q74urDNKZFx
 XR36I5Q6anECMMnIeAtzXv30hT50E/5IfAKk/k3jlas1SO0Yumpea+8LRCpLRSEWeH13
 wcW/mhQ18fxYaPeHToQ3q9xlE1OpJkh9sK5WPd2LcFsPZI3q6XTAuziyL0PzJ0EJ9cTl
 wqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N5g9cN3Lh238Dc6PZCQSi+vbuYE55lq1Tyt2HcnjTP4=;
 fh=tp4kBxbkz0qjkxifaDcsVChWT448L+8CiEbOhjlatUo=;
 b=dMzYQoP4W845yRGNMeWSzgRZDCOPcR41vDzyyS+ySHYDVWix1aqAjFhX2RTi+1bLs+
 4CC/ZrMgBt2XahIClXKy7hlaemiNjoAoqbPsPTKs5zaOKDULrxIEzzB36e5rB7e14Xtd
 kWbXPmnsp4NF6gSaYxPbbIfP0v6oawpqGEkQMPDUbefbuHoAlfd1CQUKSX8tK5eu4Zb5
 cZYbnwbadOdkMOQtESt3TwfM/0SHTdZsBGcshQ0MNPzpSTtd7aueUpIuz+Mttt90XfPs
 yHIs6UNNhDr+gNB+0175/SjGH040kETw91NpLixz3ac3lXtMDBpi466+a3EYEPn6pHC2
 rmiw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783650597; x=1784255397; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N5g9cN3Lh238Dc6PZCQSi+vbuYE55lq1Tyt2HcnjTP4=;
 b=o73s5pD6hAs8ZAZK9J0VQypqYe+N+alAvwuR0OF0EfyRhGa22Y0KchEfD6pi+YAB+F
 7Hcp0PJ/OPiLJz68TkkMvpq0GJlh30xPMSJeDsHODZL7lLIQoTjVX0r26qGriyBWah0Y
 f3ZceG9BSdCFvjvVeROKv2Ai7whxHuYh7nAhDI/BMh3LNIQ5HG9MGCWL6xvAFcqj6cKq
 ot8I0iJjkABoZcgJ5nIEUbwkmXFlgiwHqLgZ5jOPyHCiaircf2AfMygrJC42vhCYSYtT
 GnNzNB2G5qxcd5wZ4bx4mciIyj7BPvCqWyUpLKAK4psXiLFsk2KvOxmdlgmhtdLOBx3Q
 GxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783650597; x=1784255397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5g9cN3Lh238Dc6PZCQSi+vbuYE55lq1Tyt2HcnjTP4=;
 b=jAiCSd++LhYNm8cc27PMvNKdHdCu/IVhEiwzFlpeFFz1elaVJR4rVamYIxRIWbjUi2
 QCoTwsgKpN9ubZBMTi7qIIo96zr62FXzTuwiDSLxDx3EzN0IVo0wMfIa/P81XPzpwg5T
 IeM6xTHPNB6uQE6u9jaDpJQ7NIvzzND8Bu7Y0dqirmYZUOkIGo6WmKC8u1SMH9Fiuydy
 cHeq9JmFNdNSacz32OSATla5Q8XePp9WkMBFfpHOULfAa1XY6X4s6IeOb6mZVbzeVqM6
 5zPe9jLHVVhqU/bcJtbya8ZfhQ82Z5BQaUFHXRXg2HgMcC9LbFIBqpFngFJy7X92iwe4
 ofjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rolvw/lSSAQtz0KifM0Ag6YukQuZj17RHew/UnzEZBj3x99NUg27hcPdXp4N3MPNg4Pnho=@dpdk.org
X-Gm-Message-State: AOJu0YyARWWZNN91Xl6LagU7y1Oc13LpHf+7hLoI60r6oAXho9sLBzX4
 XhdvL2DuT1bV4DwAdlgJKHaXUGygr/o6Fq+5Dg802wC/sJj+V3TEH54eZQI0lU9y65IzS/OSQLq
 87pUiveZkGv78utjpt0IoEfFEJgYNHLU=
X-Gm-Gg: AfdE7cmomK8O7WZf8j3LA1MwBZ1urB8OWVNKMWRpdlzZvjUNsotccSfEPg6hXCyJgTr
 gIecjtNE+kfMfZtzjewiSJJldaAkbH+JRuOylPviZZgOTWH+AdPqSBzbH6JcgZcMB/wRfPCJxc2
 SB+SrtHcucDYndL3LbmrdmaczWeGt5z0gxQhslCl3W54o6Vftk09R8niBgzmJ525W26GJjjDRbR
 RtgBNIpiL/DVyjJAhFlVeXh7axEu+d5DhJUAJ6NQJHV+KQ//fhA4fL3gqOAHPJiysTp7KdsYfJV
 jWIn5kz5j+12Mg87KM4HS4GH4BR/zIh1/9xmrwWnNxI0Ea00BVgmFGOsUwGw7apTMNA=
X-Received: by 2002:a05:6000:4b08:b0:47d:dfea:f72e with SMTP id
 ffacd0b85a97d-47df076f0eamr9055467f8f.36.1783650596566; Thu, 09 Jul 2026
 19:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260709172823.972163-1-knimoji@iol.unh.edu>
In-Reply-To: <20260709172823.972163-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Thu, 9 Jul 2026 22:29:44 -0400
X-Gm-Features: AUfX_mwOrO67zN2U9twkRX6oSNWVsTvhH_qGosoVDuVhSvLTExsOb3745uOqX1E
Message-ID: <CAK6DuxuTW5Vg0nzOocR7-8_oFuF4qqk87uWoOeHFuc6MJEhpDw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: add code coverage reporting to DTS
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000363d2e06563884bd"
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

--000000000000363d2e06563884bd
Content-Type: text/plain; charset="UTF-8"

At this time I cannot generate a code coverage report by
passion --code-coverage when I run DTS, so I cannot merge the patch this
evening. See the ls of the meson-logs dir at the end of this email. I am
using iol-dts-tester.dpdklab.iol.unh.edu as SUT. I believe the dependencies
are met as I manually checked for them, and also there was no exception
raised for mission coverage dependencies, which your patch did add.

I will take another stab at it later and if it is user error on my part I
will apply the patch to next-dts.

2026/07/10 02:08:07 - test_run_teardown - dts.iol-TG - INFO - Sending:
'lshw -quiet -json -C network'
2026/07/10 02:08:08 - test_run_teardown - dts.iol-SUT dpdk_build - INFO -
Sending: 'lcov --version | grep -oP '\d+\.\d+''
2026/07/10 02:08:08 - test_run_teardown - dts.iol-SUT dpdk_build - INFO -
Sending: 'gcov --version | head -n 1 | grep -oP '\d+\.\d+' | tail -n 1'
2026/07/10 02:08:08 - test_run_teardown - dts.iol-SUT dpdk_build - INFO -
Sending: 'ninja -C /tmp/dts.uNWxq/dpdk/x86_64-linux-gcc coverage-html'
2026/07/10 02:11:59 - test_run_teardown - dts.iol-SUT dpdk_build - INFO -
Sending: 'tar caf /tmp/dts.uNWxq/dpdk/x86_64-linux-gcc/meson-logs.tar -C
/tmp/dts.uNWxq/dpdk/x86_64-linux-gcc meson-logs'
2026/07/10 02:12:02 - test_run_teardown - dts.iol-SUT dpdk_build - INFO -
Sending: 'rm -f /tmp/dts.uNWxq/dpdk/x86_64-linux-gcc/meson-logs.tar'
2026/07/10 02:12:02 - test_run_teardown - dts - INFO - Coverage HTML report
generated, available at output/meson-logs/coveragereport/index.html
2026/07/10 02:12:02 - test_run_teardown - dts.iol-SUT - INFO - Sending: 'rm
-rf /tmp/dts.uNWxq/dpdk'
2026/07/10 02:12:04 - test_run_teardown - dts.iol-SUT - INFO - Sending: 'rm
-f /tmp/dts.uNWxq/dpdk-26.03.tar.xz'
2026/07/10 02:12:05 - test_run_teardown - dts.iol-TG - INFO - Sending: 'rm
-rf /tmp/dts.L4Yz1'
2026/07/10 02:12:05 - test_run_teardown - dts.iol-SUT - INFO - Sending: 'rm
-rf /tmp/dts.uNWxq'
2026/07/10 02:12:05 - test_run_teardown - dts - INFO - Moving from stage
'test_run_teardown' to stage 'post_run'.
2026/07/10 02:12:05 - post_run - dts - INFO - DTS execution has ended.

Results
=======
test_suites: PASS
  rx_tx_offload: PASS
    test_mbuf_fast_free_configuration_per_port: PASS
    test_mbuf_fast_free_configuration_per_queue: SKIP
      reason: Required capability '{QUEUE_TX_OFFLOAD_MBUF_FAST_FREE}' not
found.
  blocklist: PASS
    all_but_one_port_blocklisted: PASS
    no_blocklisted: PASS
    one_port_blocklisted: PASS
  promisc_support: PASS
    promisc_packets: PASS

Test Cases Summary
==================
SKIP      = 1
PASS      = 5
BLOCK     = 0
FAIL      = 0
ERROR     = 0
PASS RATE = 100%

root@df31b2adb6c2:/dpdk/dts# ls output
output/        output.23.bak/
root@df31b2adb6c2:/dpdk/dts# ls output/meson-logs/
coverage.info.initial  coverage.info.run  meson-log.txt
root@df31b2adb6c2:/dpdk/dts#

--000000000000363d2e06563884bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">At this=C2=A0time I cannot generate a code coverage report=
 by passion=C2=A0--code-coverage when I run DTS, so I cannot merge the patc=
h this evening. See the ls of the meson-logs dir at the end of this email. =
I am using <a href=3D"http://iol-dts-tester.dpdklab.iol.unh.edu">iol-dts-te=
ster.dpdklab.iol.unh.edu</a> as SUT. I believe the dependencies are met as =
I manually checked for them, and also there was no exception raised for mis=
sion=C2=A0coverage dependencies, which your patch did add.<div><br></div><d=
iv>I will take another stab at it later and if it is user error on my part =
I will apply the patch to next-dts.<br><div><br></div><div>2026/07/10 02:08=
:07 - test_run_teardown - dts.iol-TG - INFO - Sending: &#39;lshw -quiet -js=
on -C network&#39;<br>2026/07/10 02:08:08 - test_run_teardown - dts.iol-SUT=
 dpdk_build - INFO - Sending: &#39;lcov --version | grep -oP &#39;\d+\.\d+&=
#39;&#39;<br>2026/07/10 02:08:08 - test_run_teardown - dts.iol-SUT dpdk_bui=
ld - INFO - Sending: &#39;gcov --version | head -n 1 | grep -oP &#39;\d+\.\=
d+&#39; | tail -n 1&#39;<br>2026/07/10 02:08:08 - test_run_teardown - dts.i=
ol-SUT dpdk_build - INFO - Sending: &#39;ninja -C /tmp/dts.uNWxq/dpdk/x86_6=
4-linux-gcc coverage-html&#39;<br>2026/07/10 02:11:59 - test_run_teardown -=
 dts.iol-SUT dpdk_build - INFO - Sending: &#39;tar caf /tmp/dts.uNWxq/dpdk/=
x86_64-linux-gcc/meson-logs.tar -C /tmp/dts.uNWxq/dpdk/x86_64-linux-gcc mes=
on-logs&#39;<br>2026/07/10 02:12:02 - test_run_teardown - dts.iol-SUT dpdk_=
build - INFO - Sending: &#39;rm -f /tmp/dts.uNWxq/dpdk/x86_64-linux-gcc/mes=
on-logs.tar&#39;<br>2026/07/10 02:12:02 - test_run_teardown - dts - INFO - =
Coverage HTML report generated, available at output/meson-logs/coveragerepo=
rt/index.html<br>2026/07/10 02:12:02 - test_run_teardown - dts.iol-SUT - IN=
FO - Sending: &#39;rm -rf /tmp/dts.uNWxq/dpdk&#39;<br>2026/07/10 02:12:04 -=
 test_run_teardown - dts.iol-SUT - INFO - Sending: &#39;rm -f /tmp/dts.uNWx=
q/dpdk-26.03.tar.xz&#39;<br>2026/07/10 02:12:05 - test_run_teardown - dts.i=
ol-TG - INFO - Sending: &#39;rm -rf /tmp/dts.L4Yz1&#39;<br>2026/07/10 02:12=
:05 - test_run_teardown - dts.iol-SUT - INFO - Sending: &#39;rm -rf /tmp/dt=
s.uNWxq&#39;<br>2026/07/10 02:12:05 - test_run_teardown - dts - INFO - Movi=
ng from stage &#39;test_run_teardown&#39; to stage &#39;post_run&#39;.<br>2=
026/07/10 02:12:05 - post_run - dts - INFO - DTS execution has ended.<br><b=
r>Results<br>=3D=3D=3D=3D=3D=3D=3D<br>test_suites: PASS<br>=C2=A0 rx_tx_off=
load: PASS<br>=C2=A0 =C2=A0 test_mbuf_fast_free_configuration_per_port: PAS=
S<br>=C2=A0 =C2=A0 test_mbuf_fast_free_configuration_per_queue: SKIP<br>=C2=
=A0 =C2=A0 =C2=A0 reason: Required capability &#39;{QUEUE_TX_OFFLOAD_MBUF_F=
AST_FREE}&#39; not found.<br>=C2=A0 blocklist: PASS<br>=C2=A0 =C2=A0 all_bu=
t_one_port_blocklisted: PASS<br>=C2=A0 =C2=A0 no_blocklisted: PASS<br>=C2=
=A0 =C2=A0 one_port_blocklisted: PASS<br>=C2=A0 promisc_support: PASS<br>=
=C2=A0 =C2=A0 promisc_packets: PASS<br><br>Test Cases Summary<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>SKIP =C2=A0 =C2=A0 =C2=A0=
=3D 1<br>PASS =C2=A0 =C2=A0 =C2=A0=3D 5<br>BLOCK =C2=A0 =C2=A0 =3D 0<br>FAI=
L =C2=A0 =C2=A0 =C2=A0=3D 0<br>ERROR =C2=A0 =C2=A0 =3D 0<br>PASS RATE =3D 1=
00%<br><br>root@df31b2adb6c2:/dpdk/dts# ls output<br>output/ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0output.23.bak/ <br>root@df31b2adb6c2:/dpdk/dts# ls output/meso=
n-logs/<br>coverage.info.initial =C2=A0coverage.info.run =C2=A0meson-log.tx=
t<br>root@df31b2adb6c2:/dpdk/dts#=C2=A0</div></div></div>

--000000000000363d2e06563884bd--
