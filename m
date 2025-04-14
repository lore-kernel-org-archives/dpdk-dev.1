Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C9FC369B2
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 15:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A06402CC;
	Mon, 14 Apr 2025 17:22:13 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id DB5E6402CB
 for <dev@dpdk.org>; Mon, 14 Apr 2025 17:22:11 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so2976632a12.3
 for <dev@dpdk.org>; Mon, 14 Apr 2025 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744644130; x=1745248930; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XBPzMles4AVyYbKgVsFni4f70Tj0vc0TS3uyKvq14uI=;
 b=hMRDYd8ePddfK2F5LYwl8Pq8Y3Gb2b56VDXJ9zs1tryMW9SEaoBRQtFBygod7Qn6LD
 SNYAX3GoxkQ4STO9NxkD8KJTwXzHQ/phPg4uUFKdlLrskjTn+Or0zJlKtr8kkWRwoO41
 6kM1arjPXerabjdExN3AfjYGSXz7qGA1MuE+czVpstpP7PYJLzfDAb6yGBi+I9hBWlTV
 0SCeqkhJVkQkiK/JY01cInOK0oQ8ELiL4svtcD9o7ATMIpqoN72Y2zQIHhgiCY3796z2
 ehI5QCmj/58Uz7RUp2GRFxfiNumBEZzwGYzWLAx/EdbQ/RXetM3UWC9I/y6WOUNq6Yp1
 hzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644130; x=1745248930;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBPzMles4AVyYbKgVsFni4f70Tj0vc0TS3uyKvq14uI=;
 b=D1AXfe3ctHWlYgR6Bmi/WyD2ZUxphPrdgWbxstDizF5100fwcKfGlhR/0opd22fVyq
 C0djtZ7sOiuHptZqVyjO5hU6y1X5Vs+bPArOvQaXe8Ityx2tCNrdrAzsfWWRYHtdUaLy
 MJgFlUIzVbjJt+s/yYhw24BzrXRZ6yeRFjf/UTG8hIx2zLTrC0eDF0KXIFXECX/G5N2c
 0qLLGEtLSI+bb9g2zUjQ0ZlYx5CWodfQJSWurBgDnHmJHYEuA5yAuYIeeD2JOhAo3ort
 tCRq0XQ0k+Usc+iXoEstQmQcT5yjMtVPH3QplbZzrMOs92zmZPgEYt21hj8XvEnKcP/g
 51jQ==
X-Gm-Message-State: AOJu0YyKRQBg6kQODur6bwiFi1gTp88IfTTYft8zyb+BYFHcTcciCNRp
 U3lz8JKbINFgmRLbwPmvrHC6rzf13jvDULrlyurjQ+ZiwXPqvo/mbCNWv4vNktxINUKPCsejuRe
 YzTI7TaUFx21EGrwVvyB9VTqDOvX5hKLMUn8=
X-Gm-Gg: ASbGncuHi3OSKdzXezCJr4URYPpzTBeqrPzi/kNvyG1KfD8mHuTHe6wYrS39Rnl1mGd
 uPUr34n+q/38Jb1wgzPfdv8y2GrrCfmKUpNi9jON/nhTFC8UV3bDgaDoNacZILouKgoSeyZ9twg
 dU5CAyyo2LOfJWVFPsrj1+cUo=
X-Google-Smtp-Source: AGHT+IFSYKs//v11vomgC30pbLRb98rxnifjzDiltH4FITsLzMBIvv6HwnIdJGXdbU62G1NBjKT7K89cBBrrnRkUou4=
X-Received: by 2002:a17:90a:d00c:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-3082377bf6emr18640730a91.9.1744644129890; Mon, 14 Apr 2025
 08:22:09 -0700 (PDT)
MIME-Version: 1.0
From: spyroot <spyroot@gmail.com>
Date: Mon, 14 Apr 2025 19:21:57 +0400
X-Gm-Features: ATxdqUFczZ_Pu_FMC5BsqxTc_dUAogmdRQFT2FqNAcdcGrX0U0yaX4CFbJ9GRqg
Message-ID: <CABsV3rARRuh8Qhm4q+QCDAEmA8WP+6QK241ik4qoLyGJBPFdHg@mail.gmail.com>
Subject: 810 VFIO , SRIOV, multi-process stats read DPDK testpmd.
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009f28890632be9d43"
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

--0000000000009f28890632be9d43
Content-Type: text/plain; charset="UTF-8"

Hi Folks,

I'm observing some unexpected behavior related to how statistics are
retrieved from a Physical Function (PF) on an Intel 810 NIC.

*Scenario:* I have two dpdk-testpmd instances running in separate
Kubernetes pods (same worker node). Each instance uses the -a flag to bind
to a different VF. (i.e to have consistent port id 0)

*Questions:*

   1.

   *PF Statistics and 64B Line Rate:*
   I'm noticing that the RX packet-per-second value reported on the PF side
   for a given VF is *higher than the theoretical maximum* for 64-byte
   packets.
   -

      Does the Intel 810 PMD apply any kind of optimization, offloading, or
      fast path processing when two VFs (e.g., A and B) are on the same PF?
      2.

   *Concurrent Stats Polling:*
   -

      When two separate dpdk-testpmd processes are running (in pod A and
      pod B), does the PMD or driver layer support concurrent reading of PF
      statistics?
      -

      Is there any locking or synchronization mechanism involved when
      multiple testpmd instances attempt to pull stats from the same PF
      simultaneously? ( in essence, does a firmware/OF support
concurrent read).

Thank you,

cd /usr/local/bin && dpdk-testpmd \
  --main-lcore \$main -l \$cores -n 4 \
  --socket-mem 2048 \
  --proc-type auto --file-prefix testpmd_rx0 \
  -a \$PCIDEVICE_INTEL_COM_DPDK \
  -- --forward-mode=rxonly --auto-start --stats-period 1'"

cd /usr/local/bin && dpdk-testpmd \
  --main-lcore \$main -l \$cores -n 4 \
  --socket-mem 2048 \
  --proc-type auto --file-prefix testpmd_rx1 \
  -a \$PCIDEVICE_INTEL_COM_DPDK \
  -- --forward-mode=rxonly --auto-start --stats-period 1'"

--0000000000009f28890632be9d43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p class=3D"gmail-">Hi Folks,</p>
<p class=3D"gmail-">I&#39;m observing some unexpected behavior related to h=
ow statistics are retrieved from a Physical Function (PF) on an Intel 810 N=
IC.</p>
<p class=3D"gmail-"><strong>Scenario:</strong>
I have two <code>dpdk-testpmd</code> instances running in separate Kubernet=
es pods (same worker node). Each instance uses the <code>-a</code> flag to =
bind to a different VF. (i.e to have consistent=C2=A0port id 0)=C2=A0</p>
<p class=3D"gmail-"><strong>Questions:</strong></p>
<ol>
<li class=3D"gmail-">
<p class=3D"gmail-"><strong>PF Statistics and 64B Line Rate:</strong><br>
I&#39;m noticing that the RX packet-per-second value reported on the PF sid=
e for a given VF is <strong>higher than the theoretical maximum</strong> fo=
r 64-byte packets.</p>
<ul>
<li class=3D"gmail-">
<p class=3D"gmail-">Does the Intel 810 PMD apply any kind of optimization, =
offloading, or fast path processing when two VFs (e.g., A and B) are on the=
 same PF?</p>
</li>
</ul>
</li>
<li class=3D"gmail-">
<p class=3D"gmail-"><strong>Concurrent Stats Polling:</strong></p>
<ul>
<li class=3D"gmail-">
<p class=3D"gmail-">When two separate <code>dpdk-testpmd</code> processes a=
re running (in pod A and pod B), does the PMD or driver layer support concu=
rrent reading of PF statistics?</p>
</li>
<li class=3D"gmail-">
<p class=3D"gmail-">Is there any locking or synchronization mechanism invol=
ved when multiple testpmd instances attempt to pull stats from the same PF =
simultaneously? ( in essence, does a firmware/OF support concurrent=C2=A0re=
ad).=C2=A0</p>
</li>
</ul>
</li>
</ol>
<p class=3D"gmail-">Thank you,</p></div><div><div style=3D"background-color=
:rgb(22,24,33);color:rgb(198,200,209)"><pre style=3D"font-size:10.5pt"><fon=
t face=3D"times new roman, serif"><span style=3D"color:rgb(137,184,194)">cd=
 /usr/local/bin &amp;&amp; dpdk-testpmd \<br></span><span style=3D"color:rg=
b(137,184,194)">  --main-lcore \$main -l \$cores -n 4 \<br></span><span sty=
le=3D"color:rgb(137,184,194)">  --socket-mem 2048 \<br></span><span style=
=3D"color:rgb(137,184,194)">  --proc-type auto --file-prefix testpmd_rx0 \<=
br></span><span style=3D"color:rgb(137,184,194)">  -a \$PCIDEVICE_INTEL_COM=
_DPDK \<br></span><span style=3D"color:rgb(137,184,194)">  -- --forward-mod=
e=3Drxonly --auto-start --stats-period 1&#39;&quot;</span></font></pre></di=
v></div><div><div style=3D"background-color:rgb(22,24,33);color:rgb(198,200=
,209)"><pre style=3D"font-size:10.5pt"><font face=3D"times new roman, serif=
"><span style=3D"color:rgb(137,184,194)">cd /usr/local/bin &amp;&amp; dpdk-=
testpmd \<br></span><span style=3D"color:rgb(137,184,194)">  --main-lcore \=
$main -l \$cores -n 4 \<br></span><span style=3D"color:rgb(137,184,194)">  =
--socket-mem 2048 \<br></span><span style=3D"color:rgb(137,184,194)">  --pr=
oc-type auto --file-prefix testpmd_rx1 \<br></span><span style=3D"color:rgb=
(137,184,194)">  -a \$PCIDEVICE_INTEL_COM_DPDK \<br></span><span style=3D"c=
olor:rgb(137,184,194)">  -- --forward-mode=3Drxonly --auto-start --stats-pe=
riod 1&#39;&quot;

</span></font></pre></div></div></div>

--0000000000009f28890632be9d43--
