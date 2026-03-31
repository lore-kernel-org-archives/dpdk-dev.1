Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019AFF60F4
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 18:10:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8B440613;
	Tue, 31 Mar 2026 20:10:32 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 7244E402B6
 for <dev@dpdk.org>; Tue, 31 Mar 2026 20:10:30 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1273349c56bso7544187c88.0
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774980629;
 x=1775585429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuGaRRqE3IhCrdSevUSPHZZORpS+0Jzln1FQjFqedqk=;
 b=o79Ul66OLp0qpRBOpy0Xla78Rk95TUlliJSLKubUtYkcq1Tnn7nIAkAtR/FppqRgQN
 TCwiSgmF9zAZFAWZ0k0RvIQOuQYgiB0eZaSUjyrv0w0Pm0TuX1zlMEQMP3zbHEXmNLxc
 K4D2xwJ0DSm423lg9IlXZFV5mr3pFtFUCC2T/ei31REW8tJcJ/UzbJ3a3/6EVuo46sYd
 iKNfj1Dhf5wAjfFmeKha+mXhsfqu8npOZF0rgy9cH/G/5EiQDfKhZsYsE63nxOe45M3A
 E9T5XIsUiYUiMLd1fGXyjvNh8kjh0VCSVXfPUShxkI7Po1pz1TcQO9xl33WQrwjohEiX
 vxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980629; x=1775585429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nuGaRRqE3IhCrdSevUSPHZZORpS+0Jzln1FQjFqedqk=;
 b=YRNjx6fFRKJKyEJ/575bRg0xFuzCA1o6Efg17vDbpOTPfRy1A4M5vIj5SL80IhtzqW
 p3c8IG4jcLoYfpQnj7GSdkqbPLB0m7RoqiTTuWIovXPfv+D2fE2Qszu0O1d0OR7rDDEc
 GrDvxSjkO553D4WYC40D8jLh807AA0HJ28+j3MqPy3e7uW+KvK+vU0J/uYE9u0xomju2
 A1BIa514ab4Ij9nSn3+xYSjT+EXYNODO/wfsZtlSptX8WHlVGWVTVxi0gr0xlsvsrErc
 VeNr1CS2mUnu/wO7IEfmnjArCHomYUVYb5GP4Z6uIikJNqif9z70gdbkkMTe4roRUllX
 S19w==
X-Gm-Message-State: AOJu0Ywe+CbSXyTfMcrC39wUTb/1FtbOwZU3TIooK84pDXxW5YIfI+e7
 uwoZGoAd41qXB68OdNvtjS9FSwEBSXvvX5PZEcOKa5Hxlfq4MQECE7F+3PbwELzYxME=
X-Gm-Gg: ATEYQzxjjTABpeoXrlq+CgyHo+S7RCItMr0B6YY0IRkjE5QylInevtmWpl3TM1dS7p8
 BpFc42zU1zAtDmiRt/dm30t7LodpkEwk9M+VeDRwNlBlqfplh+z7UA1Oi0X4b9oupSc5nCJIE7o
 xdgSAKNWqNX5UCBR3dmwbfkTZbGY5bXoLwK7TS2l4BD1369nKr8ksz9aW4PEKMVo2CToczl/ofV
 J5ZstNB0CqV9evYcmNsJG2zKZUPwklsq3IGAxHghPMO11cjlihdjdx5yekrvzGgQk8WkYaSe77I
 mSC1DIJOdcuVEVnS5FzM375sC9KoJdk7KCWVY/gD/cIEvbU7BpFGjlMpXaysvvanRXpRJOXzW5s
 AD+ID5OAaKBlOeiYkQS2KH8EdyOOuX5/V8GXYScf/JvBoVx/1g+h8G0zUpvmHvtf2/A+8Uwtcis
 vH8DXM7v/a5LB+Y7+1mleQv796PUPTT3vAa/w=
X-Received: by 2002:a05:7022:e01:b0:12a:949b:c46 with SMTP id
 a92af1059eb24-12be64cd277mr258193c88.21.1774980629211; 
 Tue, 31 Mar 2026 11:10:29 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12abde65313sm10223632c88.14.2026.03.31.11.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 11:10:28 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:10:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/7] Add script for real-time telemetry monitoring
Message-ID: <20260331111025.2e0b46ce@phoenix.local>
In-Reply-To: <20260205150230.123076-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260205150230.123076-1-bruce.richardson@intel.com>
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

On Thu,  5 Feb 2026 15:02:23 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> TL;DR
> ------
>=20
> For a  quick demo, apply patches, run e.g. testpmd and then in a separate
> terminal run:
>=20
>   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
>=20
> Output, updated once per second, will be traffic rate per port e.g.:
>=20
> Connected to application: "dpdk-testpmd"
> Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> 16:29:12                  5,213,119                5,214,304   10,427,423
>=20
>=20
> Fuller details
> --------------
>=20
> While we have the dpdk-telemetry.py CLI app for interactive querying of
> telemetry on the commandline, and a telemetry exporter script for
> sending telemetry to external tools for real-time monitoring, we don't
> have an app that can print real-time stats for DPDK apps on the
> terminal. This patchset adds such a script, developed with the help of
> Github copilot to fill a need that I found in my testing. Submitting it
> here in the hopes that others find it of use.
>=20
> The script acts as a wrapper around the existing dpdk-telemetry.py
> script, and pipes the commands to that script and reads the responses,
> querying it once per second. It takes a number of flag parameters, such
> as the ones above:
>  - "-d" for delta values, i.e. PPS rather than total packets
>  - "-1" for single-line output, i.e. no scrolling up the screen
>  - "-T" to display a total column
>=20
> Other flag parameters can be seen by looking at the help output.
>=20
> Beyond the flags, the script also takes a number of positional
> parameters, which refer to specific stats to display. These stats must
> be numeric values, and should take the form of the telemetry command to
> send, followed by a "." and the stat within the result which is to be
> tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
> where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
> part of the result.
>=20
> However, specifying individual stats can be awkward, so some shortcuts
> are provided too for the common case of monitoring ethernet ports. Any
> positional arg starting with "eth" will be replaced by the set of
> equivalent values for each port, e.g. "eth.imissed" will track the
> imissed value on all ports in use in the app. The ipackets and opackets
> values, as common metrics, are also available as shortened values as
> just "rx" and "tx", so in the example above, "eth.tx" means to track the
> opackets stat for every ethdev port.
>=20
> Finally, the script also has reconnection support so you can leave it
> running while you start and stop your application in another terminal.
> The watcher will try and reconnect to a running instance every second.
>=20
> v4:
> - Updated docs following AI review
> - Converted one missed f-string to regular string
>=20
> v3:
> Updated following AI review
> - removed unnecessary f-string
> - added documnentation in guides/tools
> - added release note entry
>=20
> v2:
> - improve reconnection handling, eliminating some crashes seen in testing.
>=20
> Bruce Richardson (7):
>   usertools: add new script to monitor telemetry on terminal
>   usertools/telemetry-watcher: add displaying stats
>   usertools/telemetry-watcher: add delta and timeout opts
>   usertools/telemetry-watcher: add total and one-line opts
>   usertools/telemetry-watcher: add thousands separator
>   usertools/telemetry-watcher: add eth name shortcuts
>   usertools/telemetry-watcher: support reconnection
>=20
>  doc/guides/rel_notes/release_26_03.rst |   7 +
>  doc/guides/tools/index.rst             |   1 +
>  doc/guides/tools/telemetrywatcher.rst  | 184 +++++++++++
>  usertools/dpdk-telemetry-watcher.py    | 435 +++++++++++++++++++++++++
>  usertools/meson.build                  |   1 +
>  5 files changed, 628 insertions(+)
>  create mode 100644 doc/guides/tools/telemetrywatcher.rst
>  create mode 100755 usertools/dpdk-telemetry-watcher.py
>=20
> --
> 2.51.0
>=20

This didn't get merged so will need to be rebased.
You may want to address these AI review comments.

Review of [PATCH v4 1-7/7] usertools: dpdk-telemetry-watcher
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Nice tool =E2=80=94 having a continuous monitoring wrapper around
dpdk-telemetry.py is a practical addition. Patches 1-6 are
clean and well-structured. Patch 7 (reconnection support)
has several correctness issues described below.


Patch 7/7: usertools/telemetry-watcher: support reconnection
------------------------------------------------------------

Error: monitor_stats `continue` on failed query causes
  IndexError on next delta iteration.

  When `query_telemetry` returns (process, None), the code
  does `continue`, skipping `current_values.append(...)`.
  At the end of the loop body, `prev_values =3D current_values`
  stores a shorter list. On the next iteration,
  `prev_values[i]` raises IndexError for the missing indices.

  Suggested fix: when data is None, append prev_values[i]
  (or 0) as the current_value so the list length is preserved:

    process, data =3D query_telemetry(process, command)
    if not data:
        current_values.append(prev_values[i] if i < len(prev_values) else 0)
        row +=3D "N/A".rjust(25)
        continue


Error: BrokenPipeError not handled in query_telemetry.

  When the DPDK application dies, the subprocess's stdin pipe
  breaks. The initial `process.stdin.write()` / `.flush()`
  before the reconnection loop will raise BrokenPipeError
  instead of returning an empty readline(). The reconnection
  logic never triggers.

  Suggested fix: wrap the write+flush+readline in a
  try/except (BrokenPipeError, OSError) and treat it the
  same as an empty response =E2=80=94 fall into the reconnection
  loop.


Warning: old subprocess not cleaned up on reconnection.

  In query_telemetry, when readline() returns empty and
  reconnection begins, the old process object is replaced
  without calling process.terminate() or process.wait().
  The dead subprocess accumulates as a zombie. Similarly,
  create_telemetry_process now calls print_connected_app
  which can fail and return None, leaking the just-created
  Popen object.

  Suggested fix: add a small helper to clean up a process
  (terminate, close pipes, wait), and call it before setting
  process =3D None in the reconnection path. In
  create_telemetry_process, if print_connected_app fails,
  terminate the process before returning None.


Warning: expand_shortcuts and validate_stats lose the
  reconnected process handle.

  Both functions update their local `process` variable via
  query_telemetry's return value, but neither returns the
  (possibly new) process to the caller. If a reconnection
  happens during shortcut expansion or validation, the
  caller in monitor_stats still holds the old dead process
  object.

  Suggested fix: have expand_shortcuts and validate_stats
  return the process alongside their current return values,
  or restructure so monitor_stats passes process by
  reference (e.g., as a mutable container).


Info: recursive call between create_telemetry_process and
  print_connected_app.

  create_telemetry_process calls print_connected_app, which
  calls query_telemetry, which on disconnect calls
  create_telemetry_process again. This indirect recursion
  works in practice (Python has a high default recursion
  limit and the retry loop in query_telemetry breaks the
  chain), but it is fragile and hard to follow. Consider
  separating the "connect" step from the "verify connection"
  step to avoid the recursive dependency.


Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
