Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBCC3ABB9
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 19:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61EC4402DC;
	Mon,  5 May 2025 21:47:04 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 338AE4025D
 for <dev@dpdk.org>; Mon,  5 May 2025 21:47:02 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id ED7B62115DC4; Mon,  5 May 2025 12:47:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED7B62115DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746474420;
 bh=G68G0b/RfexD+bHb4S3V39NcGUfNMXvEaRAVqKyScBA=;
 h=From:To:Cc:Subject:Date:From;
 b=TcgEa2ixnb44b9fh0yMCIuxJyuVnhqNN0zi82Yl9COo0Vd6VZCbYbdheSaM9p7RDE
 en7cr7HY6gwVn6FJTvGWipjxeUQd4+aAmtY4cmO/pSIAgSEgSqg2ZBdlJK/NLBugSk
 LkGjLjyknP2OP/ntsH5UVed1VrJPdH56ii27Uhe0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 0/1] avoid break due to failure to cleanup temporary directory
Date: Mon,  5 May 2025 12:46:44 -0700
Message-Id: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling drivers on Windows, instances have been seen where a
temporary directory fails to get cleaned up due to
ERROR_SHARING_VIOLATION (32).

Code inspection did not reveal problems with the DPDK code and scripts,
and this issue was only seen on Windows.

The proposed fix adds a mitigation for this problem, and also sets a flag
to ignore cleanup errors.

For completeness, the error message is included below.

--- stderr ---
Traceback (most recent call last):
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 631, in _rmtree_unsafe
    os.rmdir(path)
    ~~~~~~~~^^^^^^
PermissionError: [WinError 32] The process cannot access the file because it is being used by another process: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 909, in onexc
    _os.unlink(path)
    ~~~~~~~~~~^^^^^^
PermissionError: [WinError 5] Access is denied: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "V:\github\dpdk15\dpdk\buildtools\gen-pmdinfo-cfile.py", line 13, in <module>
    with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 950, in __exit__
    self.cleanup()
    ~~~~~~~~~~~~^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 954, in cleanup
    self._rmtree(self.name, ignore_errors=self._ignore_cleanup_errors)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 934, in _rmtree
    _shutil.rmtree(name, onexc=onexc)
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 790, in rmtree
    return _rmtree_unsafe(path, onexc)
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 635, in _rmtree_unsafe
    onexc(os.rmdir, path, err)
    ~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 924, in onexc
    cls._rmtree(path, ignore_errors=ignore_errors,
    ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                repeated=(path == name))
                ^^^^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\tempfile.py", line 934, in _rmtree
    _shutil.rmtree(name, onexc=onexc)
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 790, in rmtree
    return _rmtree_unsafe(path, onexc)
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 635, in _rmtree_unsafe
    onexc(os.rmdir, path, err)
    ~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.13_3.13.1008.0_x64__qbz5n2kfra8p0\Lib\shutil.py", line 631, in _rmtree_unsafe
    os.rmdir(path)
    ~~~~~~~~^^^^^^
PermissionError: [WinError 32] The process cannot access the file because it is being used by another process: 'V:\\github\\dpdk15\\dpdk\\build\\buildtools\\tmpnrqvi9nc'

[53/450] Compiling C object lib/librte_pcapng.a.p/pcapng_rte_pcapng.c.obj
ninja: build stopped: subcommand failed.

Andre Muezerie (1):
  buildtools: avoid break due to failure to cleanup temporary directory

 buildtools/gen-pmdinfo-cfile.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--
2.49.0.vfs.0.2

