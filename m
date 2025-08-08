Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E6C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 11:34:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89189402AB;
	Fri,  8 Aug 2025 13:34:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D51364028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 13:34:30 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BF65A46CD6; Fri,  8 Aug 2025 13:34:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/netuio Bug 1766] Bug in resource allocation in 
 netuio_map_hw_resources
Date: Fri, 08 Aug 2025 11:34:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: netuio
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: repin.dmitry7@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1766-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17546528700.Be3d2Caf5.640831
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
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


--17546528700.Be3d2Caf5.640831
Date: Fri, 8 Aug 2025 13:34:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1766

            Bug ID: 1766
           Summary: Bug in resource allocation in  netuio_map_hw_resources
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: Windows
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: netuio
          Assignee: dev@dpdk.org
          Reporter: repin.dmitry7@gmail.com
  Target Milestone: ---

Created attachment 327
  --> https://bugs.dpdk.org/attachment.cgi?id=3D327&action=3Dedit
corrections

We are using DPDK to work with Intel X520-DA2 under Windows with netuio. Af=
ter
adding its description to the INF file, we found that the driver fails to l=
oad:
netuio_map_hw_resources returns STATUS_DEVICE_CONFIGURATION_ERROR.

This adapter has the following resources (output from lspci -vvv in Linux):

01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
Network Connection (rev 01)
...
    Region 0: Memory at c3800000 (64-bit, non-prefetchable) [size=3D512K]=
=20=20
    Region 2: I/O ports at e020 [size=3D32]=20=20
    Region 4: Memory at c3a00000 (64-bit, non-prefetchable) [size=3D16K]=20=
=20
...

i/o port in Region 2 break the existing algorithm.

After modifying the code, the driver loaded successfully, and the adapter
started working as intended.

In the file netuio_dev.c =E2=80=94 our modification of current code.

I=E2=80=99d like to clarify why such a complex algorithm was needed. Do you=
 suspect
that WdfCmResourceListGetDescriptor might behave inconsistently across
different Windows versions?

   /*
    * ResourcesTranslated report MMIO BARs in the correct order, but their
    * indices differ from physical ones.

    * For example:
    * The values returned by WdfCmResourceListGetDescriptor can be condensed
like this:
    * Bar[0] =3D c840000c
    * Bar[1] =3D c800000c
    * Bar[2] =3D c844000c

    * But the BAR array has to be filled like this :
    * Bar[0] =3D c840000c
    * Bar[1] =3D null
    * Bar[2] =3D c800000c
    * Bar[3] =3D null
    * Bar[4] =3D c844000c
    * Bar[5] =3D null

Are you certain this is the case? Our tests don=E2=80=99t confirm this beha=
vior. we see
        descriptor[0].Type =3D CmResourceTypeMemory
        descriptor[1].Type =3D CmResourceTypeDevicePrivate
        descriptor[2].Type =3D CmResourceTypeMemory
        descriptor[3].Type =3D CmResourceTypeDevicePrivate
        descriptor[4].Type =3D CmResourceTypeMemory
        descriptor[5].Type =3D CmResourceTypeDevicePrivate

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17546528700.Be3d2Caf5.640831
Date: Fri, 8 Aug 2025 13:34:30 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - Bug in resource allocation in netuio_map_hw_resou=
rces"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1766">1766</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Bug in resource allocation in  netuio_map_hw_resources
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Windows
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>netuio
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>repin.dmitry7&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D327" name=3D"attach_327" title=3D"corrections">atta=
chment 327</a> <a href=3D"attachment.cgi?id=3D327&amp;action=3Dedit" title=
=3D"corrections">[details]</a></span>
corrections

We are using DPDK to work with Intel X520-DA2 under Windows with netuio. Af=
ter
adding its description to the INF file, we found that the driver fails to l=
oad:
netuio_map_hw_resources returns STATUS_DEVICE_CONFIGURATION_ERROR.

This adapter has the following resources (output from lspci -vvv in Linux):

01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
Network Connection (rev 01)
...
    Region 0: Memory at c3800000 (64-bit, non-prefetchable) [size=3D512K]=
=20=20
    Region 2: I/O ports at e020 [size=3D32]=20=20
    Region 4: Memory at c3a00000 (64-bit, non-prefetchable) [size=3D16K]=20=
=20
...

i/o port in Region 2 break the existing algorithm.

After modifying the code, the driver loaded successfully, and the adapter
started working as intended.

In the file netuio_dev.c =E2=80=94 our modification of current code.

I=E2=80=99d like to clarify why such a complex algorithm was needed. Do you=
 suspect
that WdfCmResourceListGetDescriptor might behave inconsistently across
different Windows versions?

   /*
    * ResourcesTranslated report MMIO BARs in the correct order, but their
    * indices differ from physical ones.

    * For example:
    * The values returned by WdfCmResourceListGetDescriptor can be condensed
like this:
    * Bar[0] =3D c840000c
    * Bar[1] =3D c800000c
    * Bar[2] =3D c844000c

    * But the BAR array has to be filled like this :
    * Bar[0] =3D c840000c
    * Bar[1] =3D null
    * Bar[2] =3D c800000c
    * Bar[3] =3D null
    * Bar[4] =3D c844000c
    * Bar[5] =3D null

Are you certain this is the case? Our tests don=E2=80=99t confirm this beha=
vior. we see
        descriptor[0].Type =3D CmResourceTypeMemory
        descriptor[1].Type =3D CmResourceTypeDevicePrivate
        descriptor[2].Type =3D CmResourceTypeMemory
        descriptor[3].Type =3D CmResourceTypeDevicePrivate
        descriptor[4].Type =3D CmResourceTypeMemory
        descriptor[5].Type =3D CmResourceTypeDevicePrivate
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1766">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17546528700.Be3d2Caf5.640831--
